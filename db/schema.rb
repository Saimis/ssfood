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

ActiveRecord::Schema.define(version: 20140206141455) do

  create_table "archyves", force: true do |t|
    t.datetime "date"
    t.integer  "restaurant_id"
    t.integer  "caller"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_time"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

# Could not dump table "userarchyves" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "food"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember"
    t.string   "password"
    t.string   "password_digest"
  end

  add_index "users", ["remember"], name: "index_users_on_remember"

end
