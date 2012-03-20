class Person < ActiveRecord::Base

  has_many :opportunities, through: :person_opportunities
  has_many :person_opportunities

  validates_presence_of :name
  attr_accessible :name, :phone

  before_save :parse_name

  private
    def parse_name
      if self.lastname.blank?
        matchdata = self.name.match(/(.*)\s(\w*)/)
        self.lastname = matchdata[2]
      end
    end

end


# == Schema Information
#
# Table name: people
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  firstname  :string(255)
#  lastname   :string(255)
#  nickname   :string(255)
#  rank       :string(255)
#  service    :string(255)
#

