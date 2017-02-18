require 'rails_helper'
require './app/services/webhooks/deliver'

RSpec.describe Webhooks::Deliver do
  it 'should make HTTP calls with the given options' do
    # Prepare
    stub_request(:post, 'www.example.com').
      to_return(body: 'okay!', status: 200)

    webhook = Webhook.new(url: 'www.example.com', headers: {}, body: '')

    # Execute
    response = described_class.call(webhook)

    # Verify
    aggregate_failures do
      expect(response).to be_success
      expect(response.body).to eq('okay!')
    end
  end

  it 'should allow HTTP Basic Auth to be specified' do
    # Prepare
    stub_request(:post, 'www.example.com').
      to_return(status: 401)

    stub_request(:post, 'www.example.com').
      with(basic_auth: ['user', 'pass']).
      to_return(status: 200)

    webhook_a = Webhook.new(url: 'www.example.com', headers: {}, body: '')
    webhook_b = Webhook.new(url: 'www.example.com', headers: {}, body: '', basic_auth_username: 'user', basic_auth_password: 'pass')

    # Execute
    response_a = described_class.call(webhook_a)
    response_b = described_class.call(webhook_b)

    # Verify
    aggregate_failures do
      expect(response_a.code).to eq(401)
      expect(response_b.code).to eq(200)
    end
  end

  it 'should allow a HTTP proxy to be specified' do
    # Prepare
    stub_request(:post, 'www.example.com').
      to_return(status: 200)

    webhook = Webhook.new(url: 'www.example.com', headers: {}, body: '', proxy_enabled: true, proxy_url: 'http://someproxy.org/')

    # Execute
    response = described_class.call(webhook)

    # Verify
    expect(response.code).to eq(200)
  end
end
