Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :webhooks, except: [:update, :destroy] do
        jsonapi_resources :deliveries
      end
    end
  end
end
