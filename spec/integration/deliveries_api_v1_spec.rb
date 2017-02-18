require 'rails_helper'
require 'securerandom'

RSpec.describe 'Deliveries API v1', type: :api do
  specify 'listing the deliveries of a given webhook' do
    webhook = Webhook.create!({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: {},
      body: ''
    })

    webhook.deliveries.create!({
      status: 'delivered'
    })

    # Execute
    remote_webhook = TestModels::Webhook.includes('deliveries').find(webhook.id).first

    # Verify
    expect(remote_webhook).to be_persisted
    expect(remote_webhook.deliveries.size).to eq(1)
    expect(remote_webhook.deliveries.first).to be_kind_of(TestModels::Delivery)
  end
end
