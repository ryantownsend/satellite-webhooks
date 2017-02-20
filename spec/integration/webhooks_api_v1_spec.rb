require 'rails_helper'
require 'securerandom'

RSpec.describe 'Webhooks API v1', type: :api do
  specify 'creating a webhook should queue a worker to deliver the webhook' do
    record = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text',
      retry_limit: 0,
      timeout: 1,
      event_source: {
        event: 'test',
        object_id: 123,
        object_type: 'Type'
      }
    })

    aggregate_failures do
      expect(record).to be_persisted
      expect(record.errors).to be_empty
      expect(WebhookDeliveryWorker.jobs.size).to eq(1)
    end
  end

  specify 'creating a webhook should be idempotent' do
    attrs = {
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text'
    }

    record_a = TestModels::Webhook.create(attrs)
    record_b = TestModels::Webhook.create(attrs)

    aggregate_failures do
      expect(record_a).to be_persisted
      expect(record_a.errors).to be_empty
      expect(record_b).to be_persisted
      expect(record_b.errors).to be_empty
    end

    expect(record_b.id).to eq(record_a.id)
  end

  specify 'creating a webhook should accept HTTP Basic Auth credentials' do
    record = TestModels::Webhook.create({
      identifier: SecureRandom.uuid,
      url: 'http://example.com/',
      headers: { 'Content-Type': 'text/plain' },
      body: 'Some plain text',
      auth: { username: 'test', password: 'password123' }
    })

    aggregate_failures do
      expect(record).to be_persisted
      expect(record.errors).to be_empty
      expect(record.auth).to match({
        username: 'test',
        password: 'password123'
      })
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
