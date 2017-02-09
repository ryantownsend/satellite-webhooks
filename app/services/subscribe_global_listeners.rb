require 'wisper'

module SubscribeGlobalListeners
  def self.call(&block)
    Wisper.subscribe(WebhookCreationListener, &block)
  end

  def self.around(_controller, &block)
    call(&block)
  end
end
