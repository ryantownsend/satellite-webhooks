require 'sidekiq'

class WebhookDeliveryWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'webhook_delivery', retry: 3

  def perform(webhook_id, delivery_service: DeliverWebhook)
    # load the record from the database
    webhook = Webhook.find(webhook_id)
    # make the HTTP call
    response = delivery_service.call({
      url: webhook.url,
      headers: webhook.headers,
      body: webhook.body
    })
    # return true or false to requeue failures
    response.success?
  end
end
