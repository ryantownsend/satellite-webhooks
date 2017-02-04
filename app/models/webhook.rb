class Webhook < ApplicationRecord
  # validation
  validates :identifier, uniqueness: { allow_blank: false }
  validates :url, :body, presence: true
end
