# frozen_string_literal: true

module Ai
	module ActiveContext
		module Code
			class MarkRepositoryAsReadyEvent < ::Encore::EventStore::Event
				def schema
					{
						'type' => 'object',

						'properties' => {},

						'additionalProperties' => false
					}
				end
			end
		end
	end
end
