require_relative './application_proxy'
Dir[File.join(File.dirname(__FILE__), 'test_models/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.before(:each, type: :api) do
    TestModels::Base.connection_options = { adapter: [:rack, application_proxy] }
  end
end
