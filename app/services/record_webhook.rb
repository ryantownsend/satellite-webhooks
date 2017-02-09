# this module records a single invocation of a webhook
module RecordWebhook
  def self.call(webhook, &block)
    # build an new delivery record
    delivery = Delivery.new(webhook_id: webhook.id, status: 'errored')

    # perform the request and record the response
    block.yield.tap do |response|
      delivery.response_time_ms     = ((response.time || 0) * 1000).to_i
      delivery.response_status_code = response.code
      delivery.response_headers     = response.headers
      delivery.response_body        = response.body
      delivery.status               = 'delivered'

      if response.timed_out?
        delivery.status = 'timed_out'
      end
    end

  rescue Net::OpenTimeout, Net::ReadTimeout => ex
    delivery.status = 'errored'

  # we should always save, even if an exception occured
  ensure
    delivery.save!
  end
end