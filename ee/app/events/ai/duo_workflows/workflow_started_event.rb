# frozen_string_literal: true

module Ai
	module DuoWorkflows
		# publicado quando um workflow transiciona para :running
		# (o agente iniciou a execução dentro do container de ci
		# depois de configuração). apenas emitido para workflows
		# (os que possuem messaging_callback_context)

		class WorkflowStartedEvent < ::Encore::EventStore::Event
			def schema
				{
					'type' => 'object',

					'required' => %w[workflow_id],

					'properties' => {
						'workflow_id' => {
							'type' => 'integer'
						}
					},

					'additionalProperties' => false
				}
			end
		end
	end
end
