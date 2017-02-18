require 'rails_helper'
require 'securerandom'

RSpec.describe 'Webhook Status Rollup' do
  specify 'when a delivery is created, it should update the status of the parent webhook' do
    # Prepare
    webhook = Webhook.create!({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: {},
      body: ''
    })

    # Execute & Verify
    expect {
      SubscribeGlobalListeners.call do
        webhook.deliveries.create!({
          status: 'delivered'
        })
      end
    }.to change(webhook, :status)
  end
end
