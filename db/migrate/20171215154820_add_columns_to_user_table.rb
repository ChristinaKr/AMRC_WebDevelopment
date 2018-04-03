class AddColumnsToUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column "users", "charity_name", :string
    add_column "users", "resexp_contact_name", :string
    add_column "users", "resexp_contact_email", :string, default: "", null:false
    add_column "users", "grants_contact_name", :string
    add_column "users", "grants_contact_email", :string, default: "", null:false
    add_column "users", "submission_status_resexp", :boolean
    add_column "users", "submission_status_grants", :integer
    add_column "users", "category", :string
    add_column "users", "username", :string, :unique => true
  end
end
