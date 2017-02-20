module Webhooks
  module CalculateStatus
    def self.call(webhook)
      deliveries = webhook.deliveries

      if deliveries.empty?
        'queued'
      elsif deliveries.any?(&:successful?)
        'delivered'
      elsif webhook.attempt_count >= webhook.attempt_limit
        'failed'
      else
        'retrying'
      end
    end
  end
end
