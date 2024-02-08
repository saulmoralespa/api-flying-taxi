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

ActiveRecord::Schema[7.1].define(version: 2024_02_06_155308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "location", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "riders_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["riders_id"], name: "index_payments_on_riders_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.bigint "riders_id"
    t.bigint "drivers_id"
    t.string "start_location", array: true
    t.string "end_location", array: true
    t.datetime "start_time"
    t.datetime "end_time"
    t.float "distance", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drivers_id"], name: "index_rides_on_drivers_id"
    t.index ["riders_id"], name: "index_rides_on_riders_id"
  end

  add_foreign_key "payments", "riders", column: "riders_id"
  add_foreign_key "rides", "drivers", column: "drivers_id"
  add_foreign_key "rides", "riders", column: "riders_id"
end
