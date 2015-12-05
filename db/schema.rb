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

ActiveRecord::Schema.define(version: 20151204234023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archyves", force: :cascade do |t|
    t.datetime "date"
    t.integer  "restaurant_id"
    t.integer  "caller"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_time"
    t.datetime "food_datetime"
    t.integer  "complete",      default: 0
    t.integer  "payer"
    t.integer  "gc"
    t.text     "callers",       default: "--- []\n"
    t.text     "payers",        default: "--- []\n"
    t.text     "gcs",           default: "--- []\n"
  end

  create_table "order_users", force: :cascade do |t|
    t.integer  "archyves_id"
    t.integer  "voted_for"
    t.string   "food"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sum"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "about"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "food"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember"
    t.string   "password"
    t.string   "password_digest"
    t.integer  "disabled",        default: 0
    t.float    "sum"
    t.string   "lastname"
  end

  add_index "users", ["remember"], name: "index_users_on_remember", using: :btree

end
