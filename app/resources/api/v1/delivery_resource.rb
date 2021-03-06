class Api::V1::DeliveryResource < JSONAPI::Resource
  # cannot be modified by the API
  immutable

  attributes :status, :response_time_ms, :response_status_code,
    :response_headers, :response_body

  # associations
  belongs_to :webhook
end
