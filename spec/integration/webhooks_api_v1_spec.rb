require 'rails_helper'
require 'securerandom'

RSpec.describe 'Webhooks API v1', type: :api do
  specify 'creating a webhook' do
    record = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text'
    })

    aggregate_failures do
      expect(record).to be_persisted
      expect(record.errors).to be_empty
    end
  end

  specify 'reading a webhook after creation' do
    record = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text'
    })

    expect(TestModels::Webhook.all.map(&:id)).to include(record.id)
  end

  specify 'updating a webhook should not be allowed' do
    record = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text'
    })

    expect {
      record.update(body: 'bla')
    }.to raise_error(ActionController::RoutingError)
  end

  specify 'deleting a webhook should not be allowed' do
    record = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text'
    })

    expect {
      record.destroy
    }.to raise_error(ActionController::RoutingError)
  end
end
