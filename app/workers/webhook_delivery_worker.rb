require 'sidekiq'

class WebhookDeliveryWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'webhook_delivery', retry: 10, dead: false

  def initialize(*)
    super
    @retry_count = -1
  end

  def perform(webhook_id, delivery_service: Webhooks::Deliver, record_service: Webhooks::RecordTransmission, sign_service: Webhooks::Sign)
    # load the record from the database
    webhook = Webhook.find(webhook_id)
    # make the HTTP call
    response = record_service.call(webhook) do
      sign_service.call(webhook)
      delivery_service.call(webhook)
    end
    # return true if successful or we've exhausted the retry limit
    response.success? || retry_count >= webhook.retry_limit
  end

  def retry_count=(value)
    @retry_count = value
  end

  def retry_count
    @retry_count + 1
  end
end
