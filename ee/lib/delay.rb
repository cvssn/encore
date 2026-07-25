# frozen_string_literal: true

module Delay
	# backoff progressivo (copiado de sidekiq como is)
	def delay(retry_count = 0)
		(retry_count**4) + 15 + (rand(30) * (retry_count + 1))
	end

	# para previnir o tempo de tentativa de armazenar dados inválidos
	# no banco de dados, capar o máximo de tempo uma hora a mais
	def next_retry_time(retry_count, custom_max_wait_time = nil)
		proposed_time = Time.zone.now + delay(retry_count).seconds

		max_wait_time = custom_max_wait_time || 1.hour
		max_future_time = max_wait_time.from_now + delay(1).seconds

		[proposed_time, max_future_time].min
	end
end
