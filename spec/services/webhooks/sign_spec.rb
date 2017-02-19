require 'rails_helper'
require './app/services/webhooks/sign'

RSpec.describe Webhooks::Sign do
  it 'should update the headers with the signatures' do
    webhook = Webhook.new(url: 'www.example.com', headers: {}, body: 'something', signatures: [
      { shared_secret: 'secret', header: 'X-Signature', algorithm: 'hmac-sha1' }
    ])

    # Execute
    described_class.call(webhook)

    # Verify
    expect(webhook.headers).to_not be_empty
    expect(webhook.headers['X-Signature']).to eq('889b4bc00e8a5d6b05c3cb47db58217cac788526')
  end
end
