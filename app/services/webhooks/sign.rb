require 'openssl'

module Webhooks
  module Sign
    ALGORITHMS = {
      'hmac-sha1':   'SHA1',
      'hmac-sha256': 'SHA256',
      'hmac-sha384': 'SHA384',
      'hmac-sha512': 'SHA512',
      'hmac-md5':    'MD5'
    }.freeze

    def self.call(webhook)
      webhook.signatures.each do |signature|
        webhook.headers[signature['header']] = hash_for(
          body: webhook.body,
          shared_secret: signature['shared_secret'],
          algorithm: signature['algorithm']
        )
      end
    end

    def self.hash_for(shared_secret:, body:, algorithm:)
      OpenSSL::HMAC.hexdigest(ALGORITHMS.fetch(algorithm.to_sym), shared_secret, body)
    end
  end
end
