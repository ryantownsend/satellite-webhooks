require 'json_api_client'

module TestModels
  class Base < JsonApiClient::Resource
    def self.path(*)
      "api/v1/#{super}"
    end
  end
end
