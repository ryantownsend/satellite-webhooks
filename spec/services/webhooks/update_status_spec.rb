require 'rails_helper'
require './app/services/webhooks/update_status'

RSpec.describe Webhooks::UpdateStatus do
  describe '.call' do
    it 'should update the webhook#status' do
      # Prepare
      fake_calculate_status = double('CalculateStatus', call: 'delivered')

      webhook = Webhook.create!({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: {},
        body: ''
      })

      # Execute
      described_class.call(webhook, calculate_status: fake_calculate_status)

      # Verify
      expect(webhook.status).to eq('delivered')
    end
  end
end
