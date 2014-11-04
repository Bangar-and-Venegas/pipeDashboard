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

ActiveRecord::Schema.define(version: 20141030154719) do

  create_table "activities", force: true do |t|
    t.datetime "add_time"
    t.datetime "update_time"
    t.integer  "user_id"
    t.integer  "deal_id"
    t.string   "activity_type"
    t.boolean  "done"
    t.string   "note"
    t.datetime "marked_as_done_time"
  end

  create_table "deals", force: true do |t|
    t.string   "title"
    t.decimal  "value"
    t.string   "currency"
    t.string   "status"
    t.datetime "won_time"
    t.integer  "user_id"
    t.datetime "add_time"
    t.datetime "update_time"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created"
    t.datetime "modified"
  end

end
