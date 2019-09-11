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

ActiveRecord::Schema.define(version: 2019_09_11_130713) do

  create_table "banned_users", force: :cascade do |t|
    t.string "email"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "grade"
    t.string "email"
    t.string "password"
    t.boolean "superuser"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "client_id"
    t.integer "wall_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "trainer_id"
    t.integer "slot"
  end

  create_table "slots", force: :cascade do |t|
    t.string "Monday_AM"
    t.string "Monday_PM"
    t.string "Tuesday_AM"
    t.string "Tuesday_PM"
    t.string "Wednesday_AM"
    t.string "Wednesday_PM"
    t.string "Thursday_AM"
    t.string "Thursday_PM"
    t.string "Friday_AM"
    t.string "Friday_PM"
    t.string "Saturday_AM"
    t.string "Saturday_PM"
    t.string "Sunday_AM"
    t.string "Sunday_PM"
  end

  create_table "trainers", force: :cascade do |t|
    t.string "name"
    t.boolean "availability"
    t.integer "grade"
  end

  create_table "walls", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "area"
  end

end
