class ApplicationRecord < ActiveRecord::Base
  include BroadcastCallbacks

  self.abstract_class = true
end
