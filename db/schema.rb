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

ActiveRecord::Schema.define(:version => 20110408154136) do

  create_table "announcements", :force => true do |t|
    t.string   "author"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "formatted_text"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "commented_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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
    t.string   "contract_type"
    t.string   "primary_service"
    t.string   "contract_duration"
    t.string   "last_updated"
    t.string   "competition_type"
    t.string   "naics"
    t.string   "primary_state_of_performance"
    t.string   "dod_civil"
    t.string   "incumbent"
    t.string   "incumbent_value"
    t.string   "incumbent_contract_number"
    t.string   "incumbent_award_date"
    t.string   "incumbent_expire_date"
    t.string   "priority"
    t.string   "vertical"
    t.string   "segment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "input_url"
    t.text     "comments"
    t.text     "summary"
    t.text     "contract_type_combined"
    t.text     "contractor_combined"
    t.text     "vertical_combined"
    t.text     "segment_combined"
    t.text     "key_contacts"
    t.integer  "input_opportunity_number"
  end

  create_table "jobs", :force => true do |t|
    t.string   "jobtype"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opportunities", :force => true do |t|
    t.string   "acronym"
    t.string   "program"
    t.string   "department"
    t.string   "agency"
    t.text     "description"
    t.string   "location"
    t.integer  "input_opportunity_number"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "input_status"
    t.string   "acquisition_url"
    t.string   "outcome"
    t.integer  "our_value"
    t.text     "search_sink"
    t.integer  "capture_manager_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "name"
    t.string   "initials"
    t.string   "color"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "watched_opportunities", :force => true do |t|
    t.integer  "opportunity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
