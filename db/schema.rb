# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_07_180722) do

  create_table "chat_subscriptions", force: :cascade do |t|
    t.integer "chat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "health_center_id"
    t.index ["chat_id", "health_center_id"], name: "index_chat_subscriptions_on_chat_id_and_health_center_id", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.string "telegram_chat_id"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "health_centers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "region"
    t.string "district"
    t.datetime "last_updated_at"
    t.string "queue_size"
    t.boolean "has_coronavac"
    t.boolean "has_pfizer"
    t.boolean "has_astrazeneca"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "district_id"
    t.integer "region_id"
  end

end
