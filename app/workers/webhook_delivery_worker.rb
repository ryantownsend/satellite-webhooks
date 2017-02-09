require 'sidekiq'

class WebhookDeliveryWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'webhook_delivery', retry: 3

  def perform(webhook_id, delivery_service: DeliverWebhook, record_service: RecordWebhook)
    # load the record from the database
    webhook = Webhook.find(webhook_id)
    # make the HTTP call
    response = record_service.call(webhook) do
      delivery_service.call({
        url: webhook.url,
        headers: webhook.headers,
        body: webhook.body,
        username: webhook.basic_auth_username,
        password: webhook.basic_auth_password
      })
    end
    # return true or false to requeue failures
    response.success?
  end
end
