require 'rails_helper'
require 'wisper'
require 'sidekiq'

RSpec.describe WebhookCreationListener do
  describe 'a webhook being created' do
    it 'should queue the webhook for delivery' do
      Wisper.subscribe(described_class) do
        expect {
          # create a webhook record
          Webhook.create({
            identifier: SecureRandom.uuid,
            url: 'http://example.com/',
            headers: { 'Content-Type': 'text/plain' },
            body: 'Some plain text'
          })
        # the job should be queued
        }.to change(WebhookDeliveryWorker.jobs, :size).by(1)
      end
    end
  end
end
