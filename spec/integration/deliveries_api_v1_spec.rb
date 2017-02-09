require 'rails_helper'
require 'securerandom'

RSpec.describe 'Deliveries API v1', type: :api do
  specify 'listing the deliveries of a given webhook' do
    # Prepare
    stub_request(:post, 'example.com').to_return(status: 200)

    # Execute
    webhook = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: {},
      body: ''
    })

    WebhookDeliveryWorker.drain

    # Verify
    expect(webhook).to be_persisted
    expect(webhook.deliveries.size).to eq(1)
    expect(webhook.deliveries.first).to be_kind_of(TestModels::Delivery)
  end
end
