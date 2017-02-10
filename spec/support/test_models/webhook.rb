require_relative './base'

module TestModels
  class Webhook < Base
    property :identifier
    property :url
    property :headers
    property :body
    property :auth
    property :retry_limit
    property :timeout

    # associations
    has_many :deliveries
  end
end
