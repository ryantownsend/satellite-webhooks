module Webhooks
  module CalculateStatus
    def self.call(webhook)
      if webhook.deliveries.any?(&:successful?)
        'delivered'
      elsif webhook.deliveries.size >= webhook.retry_limit
        'failed'
      elsif webhook.deliveries.size > 0
        'retrying'
      else
        'queued'
      end
    end
  end
end
