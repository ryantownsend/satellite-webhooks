class Delivery < ApplicationRecord
  # associations
  belongs_to :webhook

  # validation
  validates :status, inclusion: {
    allow_blank: false,
    in: %w(delivered errored timed_out)
  }

  validates :response_status_code, numericality: {
    less_than_or_equal_to: 599,
    only_integer: true,
    allow_blank: true
  }

  validates :response_time_ms, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true,
    allow_blank: true
  }

  # prevent modification once saved
  def readonly?
    persisted?
  end
end
