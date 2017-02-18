require 'spec_helper'
require './app/services/webhooks/deliver'

RSpec.describe Webhooks::Deliver do
  it 'should make HTTP calls with the given options' do
    stub_request(:post, 'www.example.com').
      to_return(body: 'okay!', status: 200)

    response = described_class.call(url: 'www.example.com', headers: {}, body: '')

    aggregate_failures do
      expect(response).to be_success
      expect(response.body).to eq('okay!')
    end
  end

  it 'should allow HTTP Basic Auth to be specified' do
    stub_request(:post, 'www.example.com').
      to_return(status: 401)

    stub_request(:post, 'www.example.com').
      with(basic_auth: ['user', 'pass']).
      to_return(status: 200)

    response_a = described_class.call(url: 'www.example.com', headers: {}, body: '')
    response_b = described_class.call(url: 'www.example.com', headers: {}, body: '', username: 'user', password: 'pass')

    aggregate_failures do
      expect(response_a.code).to eq(401)
      expect(response_b.code).to eq(200)
    end
  end
end
