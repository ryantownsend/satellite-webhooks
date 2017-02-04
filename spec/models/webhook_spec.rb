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
end
