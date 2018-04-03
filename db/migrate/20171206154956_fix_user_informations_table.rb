class FixUserInformationsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_information, :user_informations
  end
end
