require 'rails_helper'

RSpec.describe Webhook do
  describe '#save' do
    it 'should be idempotent' do
      attrs = {
        identifier: SecureRandom.uuid,
        url: 'http://example.com/',
        headers: { 'Content-Type': 'text/plain' },
        body: 'Some plain text'
      }

      record_a = Webhook.create(attrs)
      record_b = Webhook.create(attrs)

      aggregate_failures do
        expect(record_a).to be_persisted
        expect(record_a.errors).to be_empty
        expect(record_b).to be_persisted
        expect(record_b.errors).to be_empty
      end

      expect(record_b.id).to eq(record_a.id)
    end
  end

  describe '#can_retry?' do
    context 'when the attempt count is less than the limit' do
      it 'should return true' do
        webhook = Webhook.new(attempt_count: 0, attempt_limit: 1)
        expect(webhook.can_retry?).to eq(true)
      end
    end

    context 'when the attempt count is equal to the limit' do
      it 'should return false' do
        webhook = Webhook.new(attempt_count: 1, attempt_limit: 1)
        expect(webhook.can_retry?).to eq(false)
      end
    end

    context 'when the attempt count is greater than the limit' do
      it 'should return false' do
        webhook = Webhook.new(attempt_count: 5, attempt_limit: 1)
        expect(webhook.can_retry?).to eq(false)
      end
    end
  end
end
