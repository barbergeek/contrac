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

ActiveRecord::Schema.define(:version => 20110210182613) do

  create_table "input_records", :force => true do |t|
    t.string   "acronym"
    t.string   "title"
    t.string   "organization"
    t.string   "rfp_number"
    t.string   "program_value"
    t.string   "rfp_date"
    t.string   "status"
    t.string   "user_list"
    t.string   "project_award_date"
    t.string   "opportunity_id"
    t.string   "contract_type"
    t.string   "contract_type_combined"
    t.string   "primary_service"
    t.string   "contract_duration"
    t.string   "last_updated"
    t.string   "competition_type"
    t.string   "naics"
    t.string   "primary_state_of_performance"
    t.string   "summary"
    t.string   "comments"
    t.string   "dod_civil"
    t.string   "incumbent"
    t.string   "contractor_combined"
    t.string   "incumbent_value"
    t.string   "incumbent_contract_number"
    t.string   "incumbent_award_date"
    t.string   "incumbent_expire_date"
    t.string   "priority"
    t.string   "vertical"
    t.string   "vertical_combined"
    t.string   "segment"
    t.string   "segment_combined"
    t.string   "key_contacts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "input_url"
  end

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
