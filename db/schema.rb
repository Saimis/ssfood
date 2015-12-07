# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151205004637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_users", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "restaurant_id"
    t.string   "food",          limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sum"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "date"
    t.integer  "restaurant_id"
    t.integer  "caller_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_time"
    t.datetime "food_datetime"
    t.integer  "complete",             default: 0
    t.integer  "payer_id"
    t.integer  "garbage_collector_id"
    t.text     "callers",              default: "--- []\n"
    t.text     "payers",               default: "--- []\n"
    t.text     "gcs",                  default: "--- []\n"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "about",      limit: 255
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",      limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "food",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember",        limit: 255
    t.string   "password",        limit: 255
    t.string   "password_digest", limit: 255
    t.integer  "disabled",                    default: 0
    t.float    "sum"
    t.string   "lastname",        limit: 255
  end

  add_index "users", ["remember"], name: "index_users_on_remember", using: :btree

end
