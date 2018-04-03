class GrantsData < ApplicationRecord
  self.table_name = "grant_data"


  validates :charity_name, presence: true
  validates :award_value, :numericality => { :message => "must contain only numbers (please do not add '£' sign)" }, :allow_blank => true


  # imports grant data. First checks for vlaidations and if they are satisfied
  # new object is saved to database
  def self.import(file, userID)
    isvalid = true;
    CSV.foreach(file.path, encoding: 'iso-8859-1:utf-8', headers: true, :col_sep => ';') do |row|
      gd = GrantsData.new(row.to_hash.merge(userID: userID))
      if !gd.valid?
      isvalid = false
      break
    else
      isvalid = true
      gd.save
    end
  end
  isvalid
  end

  # calls query_to_csv method
  def self.all_csv(options = {})
    query_to_csv(GrantsData.all, options)
  end

  # method for downloading individual grant data.  Table is created with headers
  # from database table and populated with rows from database
  def self.particular_csv(charity_name, options = {})
    data = GrantsData.where(userID: charity_name)
    column_names = GrantsData.first.attributes.keys
    CSV.generate(options) do |csv|
      csv << column_names
      data.each do |elem|
        csv << elem.attributes.values_at(*column_names)
      end
    end
  end

  # method for downloading grant data.  Table is created with headers from
  # database table and populated with rows from database
  def self.query_to_csv(grant_data, options)
    column_names = grant_data.first.attributes.keys
    CSV.generate(options) do |csv|
      csv << column_names
      grant_data.each do |elem|
        csv << elem.attributes.values_at(*column_names)
      end
    end
  end

  # checks that grant table is not empty
  def self.has_grants
    subs = Array.new
    self.all.each do |u|
     if u.present?
       subs.push(u.userID)
     end
   end
  subs.uniq
end


# checks total number of grants entries
def self.grant_total
  grants = Array.new()
   self.all.each do |s|
     if s.award_value?
       another = GrantsData.new
       another.userID = s.userID
       another.award_value = s.award_value
       grants.push(another)
     end
   end
  grants
end

end
