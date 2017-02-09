class AddHttpBasicAuthCredentialsToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :basic_auth_username, :string
    add_column :webhooks, :basic_auth_password, :string
  end
end
