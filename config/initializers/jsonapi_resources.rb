require 'jsonapi-resources'

JSONAPI.configure do |config|
  config.json_key_format = :underscored_key

  # set some sensible limits
  config.default_page_size = 10
  config.maximum_page_size = 100

  # add pagination by default
  config.default_paginator = :offset
  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :record_count
end
