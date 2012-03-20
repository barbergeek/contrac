class PersonOpportunity < ActiveRecord::Base

  belongs_to :person
  belongs_to :opportunity

end

# == Schema Information
#
# Table name: person_opportunities
#
#  id             :integer         not null, primary key
#  person_id      :integer
#  opportunity_id :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

