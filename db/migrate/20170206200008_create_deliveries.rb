class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string  :status, null: false

      t.integer :response_time_ms
      t.integer :response_status_code
      t.jsonb   :response_headers
      t.text    :response_body

      t.belongs_to :webhook, foreign_key: true
      t.timestamps null: false
    end
  end
end
