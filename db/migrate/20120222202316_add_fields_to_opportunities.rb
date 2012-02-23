class AddFieldsToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :percent_profit, :integer
    add_column :opportunities, :registered_by_id, :integer
    add_column :opportunities, :registered_on, :date
    add_column :opportunities, :registration_method, :string
    add_column :opportunities, :registration_history, :text
    add_column :opportunities, :number_of_FTEs, :integer
    add_column :opportunities, :customer_problem, :text
    add_column :opportunities, :approach, :text
    add_column :opportunities, :services_mask, :integer
    add_column :opportunities, :pipeline_review, :boolean
  end
end
