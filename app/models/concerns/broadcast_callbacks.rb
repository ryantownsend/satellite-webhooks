require 'active_support/concern'
require 'wisper'

module BroadcastCallbacks
  extend ActiveSupport::Concern
  include Wisper::Publisher

  included do
    after_commit :publish_create_event, on: :create
    after_commit :publish_update_event, on: :update
    after_commit :publish_destroy_event, on: :destroy
  end

  private

  def publish_create_event
    broadcast("#{self.class.name.underscore}_created", self)
  end

  def publish_update_event
    broadcast("#{self.class.name.underscore}_updated", self)
  end

  def publish_destroy_event
    broadcast("#{self.class.name.underscore}_destroyed", self)
  end
end
