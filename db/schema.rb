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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110202191731) do

  create_table "opportunities", :force => true do |t|
    t.string   "acronym"
    t.string   "program"
    t.string   "department"
    t.string   "agency"
    t.text     "description"
    t.string   "location"
    t.integer  "input_number"
    t.integer  "total_value"
    t.integer  "win_probability"
    t.string   "contract_length"
    t.string   "solicitation_type"
    t.string   "contract_type"
    t.date     "rfp_release_date"
    t.date     "rfp_due_date"
    t.date     "award_date"
    t.string   "prime"
    t.string   "capture_phase"
    t.integer  "business_developer_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
