class CreateOpportunities < ActiveRecord::Migration
  def self.up
    create_table :opportunities do |t|
      t.string :acronym
      t.string :program
      t.string :department
      t.string :agency
      t.text :description
      t.string :location
      t.integer :input_id
      t.integer :total_value
      t.integer :win_probability
      t.string :contract_length
      t.string :solicitation_type
      t.string :contract_type
      t.date :rfp_release_date
      t.date :rfp_due_date
      t.date :award_date
      t.string :prime
      t.string :capture_phase
      t.integer :business_developer_id
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :opportunities
  end
end
