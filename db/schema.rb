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

ActiveRecord::Schema.define(version: 2020_03_07_000617) do

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "woeid"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "identifier"
  end

  create_table "weathers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_id"
    t.string "city"
    t.string "weather_status"
    t.float "temp_f"
    t.float "temp_c"
    t.integer "humidity"
  end

end
