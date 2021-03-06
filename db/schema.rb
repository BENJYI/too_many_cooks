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

ActiveRecord::Schema.define(version: 20170517164102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "couriers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_item_feedbacks", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "order_id"
    t.bigint "menu_item_id"
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "order_id", "menu_item_id"], name: "menu_item_feedbacks_unique_index", unique: true
    t.index ["customer_id"], name: "index_menu_item_feedbacks_on_customer_id"
    t.index ["menu_item_id"], name: "index_menu_item_feedbacks_on_menu_item_id"
    t.index ["order_id"], name: "index_menu_item_feedbacks_on_order_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "name"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_in_cents", precision: 8, scale: 2
    t.bigint "chef_id"
    t.index ["chef_id"], name: "index_menu_items_on_chef_id"
    t.index ["restaurant_id"], name: "index_menu_items_on_restaurant_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "menu_item_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_item_id"], name: "index_order_items_on_menu_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "customer_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lng"
    t.string "img_url"
    t.integer "rating", default: 0
    t.index ["manager_id"], name: "index_restaurants_on_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "type"
    t.integer "manager_id"
    t.float "lat"
    t.float "lng"
    t.decimal "balance_in_cents", precision: 8, scale: 2, default: "0.0"
    t.string "stripe_id"
    t.integer "status", default: 0
    t.integer "updown", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menu_item_feedbacks", "menu_items"
  add_foreign_key "menu_item_feedbacks", "orders"
  add_foreign_key "menu_items", "restaurants"
end
