class CreateUserInformations < ActiveRecord::Migration[5.1]
  def up
    create_table :user_information do |t|
      t.string :charity_name, limit:100
      t.string :res_exp_contact_name, limit:50
      t.string :res_exp_contact_email, limit: 100, default: "", null: false
      t.string :grants_contact_name, limit:50
      t.string :grants_contact_email, limit: 100, default: "", null: false
      t.boolean :submission_status_res_exp
      t.integer :submission_status_grants
      t.string :category
      t.string :username, :unique => true
      t.string :hashed_password

      t.timestamps
  end
  add_index("user_information", "username")
end

  def down
    drop_table :user_information
  end
end
