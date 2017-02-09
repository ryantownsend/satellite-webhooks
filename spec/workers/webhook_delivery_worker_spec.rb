require 'rails_helper'

RSpec.describe WebhookDeliveryWorker do
  describe '#perform' do
    it 'should be deliver the webhook' do
      stub_request(:post, 'example.com').
        with(basic_auth: ['test', 'password123']).
        to_return(body: 'okay!', status: 200)

      record = Webhook.create({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: { 'Content-Type' => 'text/plain' },
        body: 'Some plain text',
        basic_auth_username: 'test',
        basic_auth_password: 'password123'
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
