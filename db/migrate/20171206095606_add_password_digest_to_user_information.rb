class AddPasswordDigestToUserInformation < ActiveRecord::Migration[5.1]
  def up
    remove_column "user_information", "hashed_password"
    add_column "user_information", "password_digest", :string
  end

  def down
    remove_column "user_information", "password_digest"
    add_column "user_information", "hashed_password", :string
  end
end
