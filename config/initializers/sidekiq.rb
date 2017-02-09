puts "SIDEKIQ INITIALIZER"

require 'sidekiq'

class SidekiqRetryCountMiddleware
  def call(worker, job, queue)
    if worker.respond_to?(:retry_count)
      worker.retry_count = (job['retry_count'] || -1) + 1
    end

    yield
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add SidekiqRetryCountMiddleware
  end
end
