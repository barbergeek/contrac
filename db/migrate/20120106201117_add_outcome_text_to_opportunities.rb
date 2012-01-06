class AddOutcomeTextToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :outcome_text, :text
  end
end
