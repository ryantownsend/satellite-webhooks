class AddEventSourceToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :event_source, :jsonb
  end
end
