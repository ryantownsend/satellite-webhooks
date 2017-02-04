class CreateWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :webhooks do |t|
      t.uuid :identifier, null: false
      t.string :url, null: false
      t.jsonb :headers, null: false, default: {}
      t.text :body, null: false
      t.timestamps null: false

      t.index :identifier, unique: true
      t.index :url
    end
  end
end
