module DeliveryCreationListener
  def self.delivery_created(delivery)
    Webhooks::UpdateStatus.call(delivery.webhook)
  end
end
