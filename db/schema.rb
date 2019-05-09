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

ActiveRecord::Schema.define(version: 2019_05_09_095255) do

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.integer "total"
    t.boolean "is_canceled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id"
    t.string "home_type"
    t.string "room_type"
    t.integer "accommodates"
    t.string "city"
    t.integer "price"
    t.string "title"
    t.string "summary"
    t.boolean "has_kitchen"
    t.boolean "has_shampoo"
    t.boolean "has_heating"
    t.boolean "has_air_conditioning"
    t.boolean "has_washer"
    t.boolean "has_dryer"
    t.boolean "has_wifi"
    t.boolean "has_breakfast"
    t.boolean "has_indoor_fireplace"
    t.boolean "has_hangers"
    t.boolean "has_iron"
    t.boolean "has_hair_dryer"
    t.boolean "has_laptop_workspace"
    t.boolean "has_tv"
    t.boolean "has_crib"
    t.boolean "has_high_chair"
    t.boolean "has_self_check_in"
    t.boolean "has_smoke_detector"
    t.boolean "has_carbon_monoxide_detector"
    t.boolean "has_private_bathroom"
    t.integer "bedrooms"
    t.integer "beds"
    t.integer "bathrooms"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
