class Api::V1::WebhookResource < JSONAPI::Resource
  attributes :identifier, :url, :headers, :body

  # associations
  has_many :deliveries
end
