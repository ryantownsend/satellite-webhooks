class Webhook < ApplicationRecord
  # associations
  has_many :deliveries

  # core webhook data cannot be modified once created
  attr_readonly :identifier, :url, :headers, :body

  # validation
  validates :identifier, :url, presence: true
  validates :headers, :signatures, :event_source, json_schema: true

  validates :attempt_limit, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10,
    only_integer: true,
    allow_blank: false
  }

  validates :timeout, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 60,
    only_integer: true,
    allow_blank: false
  }

  # override save to allow for idempotent save
  def save(*)
    # do not override updates
    return super if persisted?
    # validate first
    return false if invalid?
    # attempt find
    record = self.class.find_by(identifier: identifier)
    # if found, use this record
    if record
      self.id = record.id
      @new_record = false
      id
    # otherwise perform a save
    else
      super(validate: false)
    end
  end

  def can_retry?
    attempt_count < attempt_limit
  end
end
