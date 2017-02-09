require_relative './base'

module TestModels
  class Delivery < Base
    property :status
    property :response_time_ms
    property :response_status_code
    property :response_headers
    property :response_body

    # associations
    belongs_to :webhook
  end
end
