class AddSignaturesToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :signatures, :jsonb, null: false, default: []
  end
end
