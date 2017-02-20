require 'spec_helper'
require './app/services/webhooks/calculate_status'

RSpec.describe Webhooks::CalculateStatus do
  describe '.call' do

    context 'when at least one delivery was successful' do
      it 'should return delivered' do
        deliveries = [double('Delivery', successful?: true)]
        webhook = double('Webhook', deliveries: deliveries)

        expect(described_class.call(webhook)).to eq('delivered')
      end
    end

    context 'when the attempt count has hit the limit' do
      it 'should return failed' do
        deliveries = [double('Delivery', successful?: false)]
        webhook = double('Webhook', deliveries: deliveries, attempt_count: 1, attempt_limit: 1)

        expect(described_class.call(webhook)).to eq('failed')
      end
    end

    context 'when the attempt count has not hit the limit' do
      it 'should return retrying' do
        deliveries = [double('Delivery', successful?: false)]
        webhook = double('Webhook', deliveries: deliveries, attempt_count: 1, attempt_limit: 20)

        expect(described_class.call(webhook)).to eq('retrying')
      end
    end

    context 'when there are no deliveries' do
      it 'should return queued' do
        deliveries = []
        webhook = double('Webhook', deliveries: deliveries, attempt_count: 0, attempt_limit: 1)

        expect(described_class.call(webhook)).to eq('queued')
      end
    end
  end
end
