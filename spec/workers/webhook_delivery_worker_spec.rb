require 'rails_helper'

RSpec.describe WebhookDeliveryWorker do
  describe '#perform' do
    it 'should be deliver the webhook' do
      response = double(:response, success?: true)
      delivery_service = class_spy('DeliverWebhook', call: response)

      record = Webhook.create({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: { 'Content-Type' => 'text/plain' },
        body: 'Some plain text'
      })

      result = described_class.new.perform(record.id, delivery_service: delivery_service)

      aggregate_failures do
        # successful responses should return truthy
        expect(result).to be_truthy
        # the delivery service should have been called
        expect(delivery_service).to have_received(:call)
      end
    end
  end
end
