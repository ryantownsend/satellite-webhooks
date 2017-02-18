require 'rails_helper'
require 'typhoeus'

RSpec.describe Webhooks::RecordTransmission do
  context 'with a successful response' do
    it 'should record a status of `delivered`', sidekiq_mode: :inline do
      # Prepare
      stub_request(:post, 'example.com').to_return(status: 200)

      webhook = Webhook.create!({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: {},
        body: ''
      })

      # Execute
      described_class.call(webhook) do
        Typhoeus.post(webhook.url)
      end

      # Verify
      delivery = Delivery.last
      expect(delivery.status).to eq('delivered')
    end
  end

  context 'when the response times out' do
    it 'should record a status of `timed_out`' do
      # Prepare
      stub_request(:post, 'example.com').to_timeout

      webhook = Webhook.create!({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: {},
        body: ''
      })

      # Execute
      described_class.call(webhook) do
        Typhoeus.post(webhook.url)
      end

      # Verify
      delivery = Delivery.last
      expect(delivery.status).to eq('timed_out')
    end
  end

  context 'when unable to connect' do
    it 'should record a status of `errored`' do
      # Prepare
      stub_request(:post, 'example.com').to_raise(Net::OpenTimeout)

      webhook = Webhook.create!({
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: {},
        body: ''
      })

      # Execute
      described_class.call(webhook) do
        Typhoeus.post(webhook.url)
      end

      # Verify
      delivery = Delivery.last
      expect(delivery.status).to eq('errored')
    end
  end
end
