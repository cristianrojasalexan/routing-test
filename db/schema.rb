# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_07_034215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.text "specific_cities"
    t.integer "max_stops_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vehicle_id"
    t.index ["vehicle_id"], name: "index_drivers_on_vehicle_id"
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer "load_type"
    t.float "load_sum"
    t.text "cities"
    t.integer "stops_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vehicle_id"
    t.bigint "driver_id"
    t.index ["driver_id"], name: "index_routes_on_driver_id"
    t.index ["vehicle_id"], name: "index_routes_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.float "capacity"
    t.integer "load_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "driver_id"
    t.index ["driver_id"], name: "index_vehicles_on_driver_id"
  end

  add_foreign_key "drivers", "vehicles"
  add_foreign_key "routes", "drivers"
  add_foreign_key "routes", "vehicles"
  add_foreign_key "vehicles", "drivers"
end
