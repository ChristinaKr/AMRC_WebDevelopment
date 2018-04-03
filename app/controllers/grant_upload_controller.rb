class GrantUploadController < ApplicationController

  layout 'charity_member_template'


  # method importing csv grant and ensuring that the file selected is not Empty,
  # is a csv, had the heading correct, and passes the validations.  If any of
  # these fail a flash is outputted detailing the failure
  def import
      isvalid = true;
      count = 0;
      errors = ""
      file_name = ""
      if params[:file] != nil
      if params[:file].path.include? ".csv"
      file_name = CSV.open(params[:file].path, encoding: 'iso-8859-1:utf-8', :col_sep => ';') { |csv| csv.first }
      if file_name.to_s == '["charity_name", "award_reference_number", "award_title", "award_start_date", "award_end_date", "award_value", "host_institution", "pi_first_name", "pi_surname", "award_abstract", "award_summary", "research_reference_number", "amrc_grant_type", "animal_protection", "animal_species_used", "animal_genetic_modification", "organisational_code_1", "organisational_code_2", "organisational_code_3", "organisational_code_4", "funder_comments"]'
      CSV.foreach(params[:file].path, encoding: 'iso-8859-1:utf-8', headers: true, :col_sep => ';') do |row|
        gd = GrantsData.new(row.to_hash.merge(userID: current_user.id))
        if !gd.valid?
        isvalid = false
          messages = gd.errors.full_messages
          messages.each do |e|
            errors = errors + e
          end
        break
      else
        isvalid = true
        gd.save
        count = count + 1
      end
    end
    if isvalid == true
    flash[:success] = "Successfully added " + count.to_s + " rows of grants data."
    flash[:warning] = "don't display"
    flash[:danger] = "don't display"

  else
    flash[:warning] = "Successfully added " + count.to_s + " rows of grants data.  Row " + (count+1).to_s + " invalid"
    flash[:danger] = errors
    flash[:success] = "don't display"
  end
else
  flash[:danger] = "Please ensure column names on csv are correct, if you need an example download the template file"
end
else
  flash[:danger] =   "Sorry file uploaded must be a csv"
end
else
  flash[:danger] =   "Please attatch file"

end
  render action: "grant_data"
end

end
