require_relative './base'

module TestModels
  class Webhook < Base
    property :identifier
    property :url
    property :headers
    property :body
  end
end
