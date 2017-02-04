class Api::V1::WebhookResource < JSONAPI::Resource
  attributes :identifier, :url, :headers, :body
end
