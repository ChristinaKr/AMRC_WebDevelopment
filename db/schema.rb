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

ActiveRecord::Schema.define(version: 20180110094724) do

  create_table "grant_data", force: :cascade do |t|
    t.string "charity_name"
    t.string "award_reference_number"
    t.string "award_title"
    t.date "award_start_date"
    t.date "award_end_date"
    t.decimal "award_value"
    t.string "host_institution"
    t.string "pi_first_name"
    t.string "pi_surname"
    t.text "award_abstract"
    t.text "award_summary"
    t.string "research_reference_number"
    t.string "amrc_grant_type"
    t.boolean "animal_protection"
    t.string "animal_species_used"
    t.boolean "animal_genetic_modification"
    t.string "organisational_code_1"
    t.string "organisational_code_2"
    t.string "organisational_code_3"
    t.string "organisational_code_4"
    t.text "funder_comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "userID"
  end

  create_table "projects", force: :cascade do |t|
    t.string "charity_name"
    t.float "research_spending"
    t.string "financial_year"
    t.boolean "audited_account"
    t.string "spending_research_overseas"
    t.string "spending_uk_capital_projects"
    t.string "spending_overseas_capital_projects"
    t.string "spending_brief_of_capital_projects"
    t.string "spending_other_non_medical_research_charitable_activities"
    t.string "total_charitable_expenditure"
    t.string "estimated_spending_on_medical_research"
    t.boolean "use_of_data_approve_graphs"
    t.boolean "use_of_data_share_aggreement"
    t.string "approval_name"
    t.string "approval_job_title"
    t.string "approval_description"
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "userID"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_role", default: false
    t.boolean "charity_role", default: true
    t.string "charity_name"
    t.string "resexp_contact_name"
    t.string "resexp_contact_email", default: "", null: false
    t.string "grants_contact_name"
    t.string "grants_contact_email", default: "", null: false
    t.boolean "submission_status_resexp", default: false
    t.string "category"
    t.boolean "submission_status_grants", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
