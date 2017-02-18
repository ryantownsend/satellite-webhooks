require 'typhoeus'

# this module performs the transmission of a HTTP call
module Webhooks
  module Deliver
    def self.call(url:, headers:, body:, timeout: 5, username: nil, password: nil)
      # if we have HTTP Basic Auth username / password, pass them
      if username || password
        userpwd = "#{username}:#{password}"
      end

      # make the HTTP call
      Typhoeus.post url, headers: headers,
                         userpwd: userpwd,
                         body: body,
                         timeout: timeout,
                         accept_encoding: 'gzip'
    end
  end
end
