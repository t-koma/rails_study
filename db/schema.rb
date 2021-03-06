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

ActiveRecord::Schema.define(version: 2019_12_26_022348) do

  create_table "admins", force: :cascade do |t|
    t.string "user_id"
    t.text "name"
    t.string "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: :cascade do |t|
    t.date "bank_day"
    t.integer "warehousing"
    t.text "wh_id"
    t.integer "money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "return_money"
    t.boolean "check_edit"
  end

  create_table "claims", force: :cascade do |t|
    t.date "claim_day"
    t.text "user_id"
    t.integer "claim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pay"
  end

  create_table "collects", force: :cascade do |t|
    t.text "user_id"
    t.integer "collect"
    t.date "collect_day"
    t.text "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "claim_id"
  end

  create_table "hopes", force: :cascade do |t|
    t.text "user_id"
    t.text "contents"
    t.boolean "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saves", force: :cascade do |t|
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
