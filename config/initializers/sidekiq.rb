require 'sidekiq'

class SidekiqRetryCountMiddleware
  def call(worker, job, queue)
    if worker.respond_to?(:retry_count)
      worker.retry_count = (job['retry_count'] || -1) + 1
    end

    yield
  end
end

class SidekiqGlobalListenersMiddleware
  def call(worker, job, queue)
    SubscribeGlobalListeners.call do
      yield
    end
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add SidekiqRetryCountMiddleware
    chain.add SidekiqGlobalListenersMiddleware
  end
end
