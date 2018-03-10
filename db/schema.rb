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

ActiveRecord::Schema.define(version: 20180216034034) do

  create_table "alerts", force: :cascade do |t|
    t.integer "social_watcher_id"
    t.string "data_id"
    t.text "text"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_id"], name: "index_alerts_on_data_id"
    t.index ["social_watcher_id"], name: "index_alerts_on_social_watcher_id"
  end

  create_table "listeners", force: :cascade do |t|
    t.string "query"
    t.string "token"
    t.string "email"
    t.string "phone_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_listeners_on_token"
  end

  create_table "social_watchers", force: :cascade do |t|
    t.integer "listener_id"
    t.integer "source"
    t.integer "score"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listener_id"], name: "index_social_watchers_on_listener_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "guest"
    t.string "email"
    t.string "password_hash"
    t.string "password_salt"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
