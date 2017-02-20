class AddAttemptCountToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :attempt_count, :integer, null: false, default: 0
    rename_column :webhooks, :retry_limit, :attempt_limit
  end
end
