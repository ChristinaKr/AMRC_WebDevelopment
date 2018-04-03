class CreateGrantData < ActiveRecord::Migration[5.1]
  def up
    create_table :grant_data do |t|
      t.string :charity_name
      t.string :award_reference_number
      t.string :award_title
      t.date :award_start_date
      t.date :award_end_date
      t.decimal :award_value
      t.string :host_institution
      t.string :pi_first_name
      t.string :pi_surname
      t.text :award_abstract
      t.text :award_summary
      t.string :research_reference_number
      t.string :amrc_grant_type
      t.boolean :animal_protection
      t.string :animal_species_used
      t.boolean :animal_genetic_modification
        t.string :organisational_code_1
      t.string :organisational_code_2, :null => true
      t.string :organisational_code_3, :null => true
      t.string :organisational_code_4,  :null => true
      t.text :funder_comments, :null => true

      t.timestamps
    end
    end

    def down
      drop_table :grant_data
  end
end
