module Webhooks
  module CalculateStatus
    def self.call(webhook)
      deliveries = webhook.deliveries

      if deliveries.empty?
        'queued'
      elsif deliveries.any?(&:successful?)
        'delivered'
      elsif !webhook.can_retry?
        'failed'
      else
        'retrying'
      end
    end
  end
end
