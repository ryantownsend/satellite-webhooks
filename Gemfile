source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# API framework
gem 'jsonapi-resources', '0.9.0.beta3'
# Background Workers
gem 'sidekiq', '4.2.9'
# HTTP Library
gem 'typhoeus', '>= 1.1.2', '~> 1.1'
# Internal Pubsub
gem 'wisper', '2.0.0.rc1'
# JSON Validation
gem 'json-schema', '~> 2.8', '2.8.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development do
  gem 'reek', '~> 4.5'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'factory_girl_rails', '~> 4.7'
  gem 'faker', '~> 1.6'
  gem 'json_api_client', '~> 1.4'
  gem 'webmock', '>= 2.3.2', '~> 2.3'
end
