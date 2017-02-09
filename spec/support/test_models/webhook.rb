require_relative './base'

module TestModels
  class Webhook < Base
    property :identifier
    property :url
    property :headers
    property :body
    property :auth

    # associations
    has_many :deliveries
  end
end
