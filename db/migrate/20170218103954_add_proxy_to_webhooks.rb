class AddProxyToWebhooks < ActiveRecord::Migration[5.0]
  def change
    add_column :webhooks, :proxy_enabled, :boolean, null: false, default: false
    add_column :webhooks, :proxy_url, :string
  end
end
