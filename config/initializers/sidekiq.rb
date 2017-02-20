require 'sidekiq'

class SidekiqGlobalListenersMiddleware
  def call(worker, job, queue)
    SubscribeGlobalListeners.call do
      yield
    end
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add SidekiqGlobalListenersMiddleware
  end
end
