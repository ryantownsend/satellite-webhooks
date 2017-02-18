require_relative './calculate_status'

module Webhooks
  module UpdateStatus
    def self.call(webhook, calculate_status: CalculateStatus)
      status = calculate_status.call(webhook)
      webhook.update!(status: status)
    end
  end
end
