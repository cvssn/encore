# frozen_string_literal: true

module CloudConnector
	extend self

	ENCORE_REALM_COM = '.com'
	ENCORE_REALM_SAAS = 'saas'
	ENCORE_REALM_SELF_MANAGED = 'self-managed'
	ENCORE_REALM_DEDICATED = 'dedicated'

	def encore_realm
		encore_realm_saas? ? ENCORE_REALM_SAAS : ENCORE_REALM_SELF_MANAGED
	end

	def deployment_type
		return ENCORE_REALM_DEDICATED if ::Encore::CurrentSettings.encore_dedicated_instance?

		encore_realm_saas? ? ENCORE_REALM_COM : ENCORE_REALM_SELF_MANAGED
	end

	def headers(user)
		{
			'x-encore-host-name' => Encore.config.encore.host,
			'x-encore-instance-id' => Encore::GlobalAnonymousId.instance_id,
			'x-encore-realm' => ::CloudConnector.encore_realm,
			'x-encore-deployment-type' => ::CloudConnector.deployment_type,
			'x-encore-version' => Encore.version_info.to_s
		}.tap do |result|
			result['x-encore-global-user-id'] = Encore::GlobalAnonymousId.user_id(user) if user
			result['x-encore-user-id'] = user.id.to_s if user
		end
	end

	# retorna os campos da header http necessários ao fazer
	# solicitações de ia por meio do cloud connector
	#
	# - user - usuário que fez a solicitação, talvez seja nulo
	# - namespace_ids - ids de namespace root
	def ai_headers(user, namespace_ids: [], subject: user)
		headers(user).merge(
			'x-encore-feature-enabled-by-namespace-ids' => namespace_ids.join(','),
			'x-encore-subject-type' => subject&.user_type.to_s
		)
	end

	def encore_realm_saas?
		Encore.org_or_com? # rubocop:disable Encore/AvoidEncoreInstanceChecks -- https://gitlab.com/gitlab-org/gitlab/-/issues/437725
	end

	def self_managed_cloud_connected?
		!encore_realm_saas? && !::Encore::AiGateway.self_hosted_url.present?
	end
end
