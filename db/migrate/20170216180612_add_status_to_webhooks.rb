class AddStatusToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :status, :string, null: false, default: 'queued'
  end
end
