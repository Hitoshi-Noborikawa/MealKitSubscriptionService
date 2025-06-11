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

ActiveRecord::Schema[8.0].define(version: 2025_06_11_132025) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "postal_code", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.date "delivery_date", null: false
    t.integer "time_slot", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.text "delivery_memo"
    t.integer "total_price", default: 0, null: false
    t.integer "total_price_with_tax", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id", null: false
    t.integer "shipping_fee", default: 0, null: false
    t.integer "frozen_fee", default: 0, null: false
    t.integer "cod_fee", default: 0, null: false
    t.integer "schedule_fee", default: 0, null: false
    t.index ["address_id"], name: "index_deliveries_on_address_id"
    t.index ["subscription_id"], name: "index_deliveries_on_subscription_id"
  end

  create_table "delivery_meal_sets", force: :cascade do |t|
    t.bigint "delivery_id", null: false
    t.bigint "meal_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1, null: false
    t.index ["delivery_id", "meal_set_id"], name: "index_delivery_meal_sets_on_delivery_id_and_meal_set_id", unique: true
    t.index ["delivery_id"], name: "index_delivery_meal_sets_on_delivery_id"
    t.index ["meal_set_id"], name: "index_delivery_meal_sets_on_meal_set_id"
  end

  create_table "meal_set_items", force: :cascade do |t|
    t.bigint "meal_set_id", null: false
    t.bigint "meal_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_meal_set_items_on_meal_id"
    t.index ["meal_set_id"], name: "index_meal_set_items_on_meal_set_id"
  end

  create_table "meal_sets", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description", default: ""
  end

  create_table "meals", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "refrigeration", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", default: 0, null: false
    t.integer "meal_sets_count", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.integer "frequency", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.datetime "paused_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number", default: "", null: false
    t.text "allergy_notes", default: "", null: false
    t.boolean "suspended", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "deliveries", "addresses"
  add_foreign_key "deliveries", "subscriptions"
  add_foreign_key "delivery_meal_sets", "deliveries"
  add_foreign_key "delivery_meal_sets", "meal_sets"
  add_foreign_key "meal_set_items", "meal_sets"
  add_foreign_key "meal_set_items", "meals"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
end
