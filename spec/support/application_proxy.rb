# this module provides a connection object which calls the Rails app and
# stores the responses in an instance variable, allowing for inspection

module ApplicationProxy
  def application_proxy
    @application_proxy ||= -> (env) do
      Rails.application.call(env).tap do |(status, headers, body)|
        rack_response = ::Rack::MockResponse.new(status, headers, body, env['rack.errors'].flush)
        response = ::ActionDispatch::TestResponse.from_response(rack_response)
        instance_variable_set(:@response, response)
      end
    end
  end
end

RSpec.configure do |config|
  config.include ApplicationProxy
end
