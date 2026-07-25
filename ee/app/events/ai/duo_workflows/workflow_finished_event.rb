# frozen_string_literal: true

module Ai
	module DuoWorkflows
		# publicado quando um workflow transiciona para :finished
		# (agente completo com sucesso). apenas emitido para
		# workflows. permite que as respostas de @encoreduo/slack
		# sejam enviadas em tempo finalizado em vez de esperar
		# pelo último ci::workloads::workloadfinishedevent
		# (finalização de pipeline de ci)

		class WorkflowFinishedEvent < ::Encore::EventStore::Event
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
