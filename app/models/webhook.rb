class Webhook < ApplicationRecord
  # validation
  validates :identifier, :url, :body, presence: true

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
end
