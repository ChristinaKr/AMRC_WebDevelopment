class Changegrantdefault < ActiveRecord::Migration[5.1]
  def self.up
      add_column :users, :submission_status_grants_convert, :boolean, :default => false

      # look up the schema's to be able to re-inspect the Project model
      # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
      User.reset_column_information

      # loop over the collection
      User.all.each do |p|
          p.submission_status_grants_convert = p.submission_status_grants == '1'
          p.save
      end

      # remove the older status column
      remove_column :users, :submission_status_grants
      # rename the convert_status to status column
      rename_column :users,:submission_status_grants_convert,:submission_status_grants
    end

    def self.down
      add_column :users, :submission_status_grants_convert, :boolean, :default => true

      # look up the schema's to be able to re-inspect the Project model
      # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
      User.reset_column_information

      # loop over the collection
      User.all.each do |p|
          p.submission_status_grants_convert = p.submission_status_grants == '1'
          p.save
      end

      # remove the older status column
      remove_column :users, :submission_status_grants
      # rename the convert_status to status column
      rename_column :users,:submission_status_grants_convert,:submission_status_grants
    end


end
