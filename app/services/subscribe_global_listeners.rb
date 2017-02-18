require 'wisper'

module SubscribeGlobalListeners
  LISTENERS = [
    DeliveryCreationListener,
    WebhookCreationListener
  ].freeze

  def self.call(&block)
    Wisper.subscribe(*LISTENERS, &block)
  end

  def self.around(_controller, &block)
    call(&block)
  end
end
