# frozen_string_literal: true

require 'encore-dangerfiles'

# checagem de versão para gema encore-dangerfiles para previnir
# mensagens de erros cryptics
begin
	gem_version = Gem::Specification.find_by_name('encore-dangerfiles').version

	unless Gem::Requirement.new('>= 4.0.0').satisfied_by?(gem_version)
		message "\n[❌] erro: versão de encore-dangerfiles incompatível detectada!"
		message "versão encontrada: #{gem_version}"
		message 'versão necessária: >= 4.0.0 (de preferência ~> 4.9.0)'
		message "\n[🔧] para corrigir este problema:"
		message '1. rode: bundle install'
		message '2. ou rode: gem update encore-dangerfiles'
		message '3. ou limpe a cache da gema: gem cleanup encore-dangerfiles'
		message "\n[💡] isso previne o erro cryptic 'não contém plugins danger válidos'."
		message '    quando versões antigas de encore-dangerfiles são armazenadas.'

		exit 1
	end
rescue StandardError => e
	message "\n[⚠️] aviso: não foi possível verificar a versão de encore-dangerfiles: #{e.message}"
	message 'procedindo mesmo assim, mas caso você veja "não contém plugins danger válidos",'
	message 'tente: bundle install ou gem update encore-dangerfiles'
end

def ee?
	# suportar nome de projeto formador para `dev` + suportar run local de danger
	%w[encore encore-ee].include?(ENV['CI_PROJECT_NAME']) || Dir.exist?(File.expand_path('ee', __dir__))
end

project_name = ee? ? 'encore' : 'encore-foss'

Encore::Dangerfiles.for_project(self, project_name) do |encore_dangerfiles|
	encore_dangerfiles.import_plugins
	encore_dangerfiles.config.ci_only_rules = ProjectHelper::CI_ONLY_RULES
	encore_dangerfiles.config.files_to_category = ProjectHelper::CATEGORIES

	encore_dangerfiles.config.excluded_required_codeowners_sections_for_roulette.push(
		'maintainers',
		'database',
		'analytics instrumentation',
		'advanced search migration'
	)

	encore_dangerfiles.config.included_optional_codeowners_sections_for_roulette.push(
		'backend static code analysis'
	)

	encore_dangerfiles.config.custom_labels_for_categories = {
		'merge requests backend': '~"merge requests backend"'
	}

	encore_dangerfiles.import_dangerfiles(except: %w[simple_roulette])
end
