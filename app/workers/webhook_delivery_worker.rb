require 'sidekiq'

class WebhookDeliveryWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'webhook_delivery', retry: 10, dead: false

  def perform(webhook_id, delivery_service: Webhooks::Deliver, record_service: Webhooks::RecordTransmission, sign_service: Webhooks::Sign)
    Webhook.connection_pool.with_connection do |conn|
      # load the record from the database
      webhook = Webhook.find(webhook_id)
      # increment the attempt count
      webhook.increment!(:attempt_count)
      # make the HTTP call
      response = record_service.call(webhook) do
        sign_service.call(webhook)
        delivery_service.call(webhook)
      end
      # return true if successful or we've exhausted the attempts limit
      response.success? || !webhook.can_retry?
    end
  end
end
