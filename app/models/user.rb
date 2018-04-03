class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :charity_name, presence: true

validates :resexp_contact_name, presence: true
validates :grants_contact_name, presence: true
validates :category, presence: true

validates :resexp_contact_email, presence: true, format: { with: VALID_EMAIL_REGEX }
validates :grants_contact_email, presence: true, format: { with: VALID_EMAIL_REGEX }
validates :email, format: { with: VALID_EMAIL_REGEX }

  # checks if charity is admin
  def admin?
    self.admin_role
  end

  # checks if research expenditure form has been marked complete
  def self.marked_complete_rex
      rows = Array.new()
      self.all.each do |row|
         if row.submission_status_resexp != false
          rows.push(row.id)
         end
      end
        rows
  end

  # checks if grant data has been marked complete
  def self.marked_complete_grants
      rows = Array.new()
      self.all.each do |row|
         if row.submission_status_grants != false
          rows.push(row.id)
         end
      end
        rows
  end

  # gets array of all userIDs which are not admin
  def self.get_array
    rows = Array.new()
      self.all.each do |row|
        if row.admin_role != true
          rows.push(row.id)
        end
      end
      rows

  end

  # checks if charity is an admin
  def self.is_admin(id)
    charity = find(id)
    if charity.admin_role == false
      false
    else
    true
  end
  end

  # checks if charity is a charity
  def self.is_charity(id)
    if id != nil
    charity = find(id)
    if charity.charity_role == false
      false
    else
    true
  end
else
  false
end
  end

  # find catagory of certain charity
  def self.find_category(id)
    charity = find(id)
    charity.category
  end

  # finds all ids for all submitted research forms
  def self.research_sub_list
    complete = Project.completed_forms.concat User.marked_complete_rex
    complete = complete.uniq

    complete.each do |c|

      if !User.is_charity(c)
        complete = complete - [c]
      end
    end
    complete
  end

  # finds all ids for all submitted grant entries
  def self.grants_sub_list
    users = GrantsData.has_grants.concat User.marked_complete_grants
    subs = Array.new()
    users.each do |u|
      if User.is_charity(u)
        subs.push(u)
      end
    end
    subs
  end


  # creates csv of all charties that have not submitted data yet. If they have
  # not submitted grants data they will output email adderess and contact name
  # for the grants section and the same for research.  The same is true for
  # the research form.  Charity name is also returned.
  def self.to_csv_unsubmitted
    attributes = %w{charity_name resexp_contact_name resexp_contact_email grants_contact_name grants_contact_email}
    attributes1 = %w{charity_name resexp_contact_name resexp_contact_email}
    attributes2 = %w{charity_name nil nil grants_contact_name grants_contact_email}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      User.all.each do |elem|
        if (!(User.research_sub_list.include? elem.id) && User.is_charity(elem.id)) &&
          (!(User.grants_sub_list.include? elem.id) && User.is_charity(elem.id))
          csv << elem.attributes.values_at(*attributes)

        elsif !(User.research_sub_list.include? elem.id) && User.is_charity(elem.id)
        csv << elem.attributes.values_at(*attributes1)

      elsif !(User.grants_sub_list.include? elem.id) && User.is_charity(elem.id)
      csv << elem.attributes.values_at(*attributes2)
    end
      end
    end
  end



end
