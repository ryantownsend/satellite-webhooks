class Webhook < ApplicationRecord
  # validation
  validates :identifier, unique: { allow_blank: false }
  validates :url, :body, presence: true
end
