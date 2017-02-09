require 'rails_helper'

RSpec.describe WebhookDeliveryWorker do
  describe '#perform' do
    it 'should be deliver the webhook' do
      stub_request(:post, 'example.com').
        to_return(body: 'okay!', status: 200)

      record = Webhook.create({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: { 'Content-Type' => 'text/plain' },
        body: 'Some plain text'
      })

      result = described_class.new.perform(record.id)

      aggregate_failures do
        # successful responses should return truthy
        expect(result).to be_truthy
        # there should be a recorded delivery
        expect(record.deliveries.size).to eq(1)
      end
    end
  end
end
