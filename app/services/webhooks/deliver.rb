require 'typhoeus'

# this module performs the transmission of a HTTP call
module Webhooks
  GLOBAL_HTTP_PROXY_URL = (ENV['HTTP_PROXY_URL'] || ENV['QUOTAGUARDSTATIC_URL'] || ENV['FIXIE_URL']).freeze

  module Deliver
    def self.call(webhook)
      # if we have HTTP Basic Auth username / password, pass them
      if webhook.basic_auth_username || webhook.basic_auth_password
        userpwd = "#{webhook.basic_auth_username}:#{webhook.basic_auth_password}"
      end

      # if the webhook should be sent via a custom HTTP proxy
      if webhook.proxy_url.present?
        proxy = webhook.proxy_url
      # if the webhook should be sent via the system HTTP proxy
      elsif webhook.proxy_enabled?
        proxy = GLOBAL_HTTP_PROXY_URL
      end

      # make the HTTP call
      Typhoeus.post webhook.url,
        headers: webhook.headers,
        userpwd: userpwd,
        body: webhook.body,
        timeout: webhook.timeout || 5,
        accept_encoding: 'gzip',
        proxy: proxy
    end
  end
end
