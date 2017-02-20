# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170220184551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deliveries", force: :cascade do |t|
    t.string   "status",               null: false
    t.integer  "response_time_ms"
    t.integer  "response_status_code"
    t.jsonb    "response_headers"
    t.text     "response_body"
    t.integer  "webhook_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["webhook_id"], name: "index_deliveries_on_webhook_id", using: :btree
  end

  create_table "webhooks", force: :cascade do |t|
    t.uuid     "identifier",                             null: false
    t.string   "url",                                    null: false
    t.jsonb    "headers",             default: {},       null: false
    t.text     "body",                                   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "basic_auth_username"
    t.string   "basic_auth_password"
    t.integer  "attempt_limit",       default: 3,        null: false
    t.integer  "timeout",             default: 5,        null: false
    t.string   "status",              default: "queued", null: false
    t.boolean  "proxy_enabled",       default: false,    null: false
    t.string   "proxy_url"
    t.jsonb    "signatures",          default: [],       null: false
    t.jsonb    "event_source"
    t.integer  "attempt_count",       default: 0,        null: false
    t.index ["identifier"], name: "index_webhooks_on_identifier", unique: true, using: :btree
    t.index ["url"], name: "index_webhooks_on_url", using: :btree
  end

  add_foreign_key "deliveries", "webhooks"
end
