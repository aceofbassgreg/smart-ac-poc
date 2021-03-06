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

ActiveRecord::Schema.define(version: 2018_11_02_005550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "serial_number", null: false
    t.datetime "registration_date", default: "2018-10-29 00:00:00", null: false
    t.string "firmware_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serial_number"], name: "index_devices_on_serial_number", unique: true
  end

  create_table "sensor_readings", force: :cascade do |t|
    t.integer "temperature"
    t.decimal "carbon_monoxide_level"
    t.decimal "air_humidity_percentage"
    t.string "device_health"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "time_recorded"
    t.index ["device_id"], name: "index_sensor_readings_on_device_id"
  end

  create_table "sensor_warnings", force: :cascade do |t|
    t.integer "warning_type"
    t.boolean "resolved"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_sensor_warnings_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_access_token"
    t.index ["api_access_token"], name: "index_users_on_api_access_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sensor_readings", "devices"
  add_foreign_key "sensor_warnings", "devices"
end
