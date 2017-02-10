class AddRetryLimitToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :retry_limit, :integer, default: 3, null: false
  end
end
