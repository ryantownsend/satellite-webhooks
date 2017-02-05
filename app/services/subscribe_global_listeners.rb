require 'wisper'

class SubscribeGlobalListeners
  def self.call(&block)
    Wisper.subscribe(WebhookCreationListener, &block)
  end

  def self.around(controller, &block)
    call(&block)
  end
end
