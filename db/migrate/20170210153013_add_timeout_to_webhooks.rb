class AddTimeoutToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :timeout, :integer, default: 5, null: false
  end
end
