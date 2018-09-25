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

ActiveRecord::Schema.define(version: 2018_09_04_062852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "j_id", default: ""
    t.string "org_name", default: ""
    t.string "person_kind", default: ""
    t.string "rank", default: ""
    t.string "title", default: ""
    t.string "sysnam", default: ""
    t.string "number_of", default: ""
    t.string "gender_type", default: ""
    t.string "work_place_type", default: ""
    t.string "date_from", default: ""
    t.string "date_to", default: ""
    t.string "is_handicap", default: ""
    t.string "is_original", default: ""
    t.string "is_local_original", default: ""
    t.string "is_traing", default: ""
    t.string "j_type", default: ""
    t.string "vitae_email", default: ""
    t.string "work_quality", default: ""
    t.string "work_item", default: ""
    t.string "work_address", default: ""
    t.string "contact_method", default: ""
    t.string "url_link", default: ""
    t.string "view_url", default: ""
    t.string "announce_date", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
