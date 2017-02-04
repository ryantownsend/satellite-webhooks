require 'wisper'

class ApplicationController < JSONAPI::ResourceController
  around_action :subscribe_global_listeners

  private

  def subscribe_global_listeners(&block)
    Wisper.subscribe(WebhookCreationListener, &block)
  end
end
