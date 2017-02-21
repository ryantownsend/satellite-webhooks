# frozen_string_literal: true
require 'json-schema'

class JsonSchemaValidator < ActiveModel::EachValidator
  SCHEMA_DIR = Rails.root.join('db/json_schemas').expand_path

  def validate_each(record, attribute, value)
    # load our schema file
    schema_file = SCHEMA_DIR.join("#{record.class.name.underscore}.#{attribute}.json").to_s
    # validate the input using JSON Schema
    errors = ::JSON::Validator.fully_validate(schema_file, value, strict: true)
    # parse the errors
    errors.each do |error|
      record.errors.add(attribute, error.gsub("file://#{SCHEMA_DIR}/", ''), value: value)
    end
  end
end
