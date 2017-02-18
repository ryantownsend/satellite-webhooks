module Webhooks
  module CalculateStatus
    def self.call(webhook)
      deliveries = webhook.deliveries

      if deliveries.any?(&:successful?)
        'delivered'
      elsif deliveries.size >= webhook.retry_limit
        'failed'
      elsif deliveries.size > 0
        'retrying'
      else
        'queued'
      end
    end
  end
end
