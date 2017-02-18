module WebhookCreationListener
  def self.webhook_created(webhook)
    WebhookDeliveryWorker.perform_async(webhook.id)
  end
end
