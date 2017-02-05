class ApplicationController < JSONAPI::ResourceController
  around_action SubscribeGlobalListeners
end
