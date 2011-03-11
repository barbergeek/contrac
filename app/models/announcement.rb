# == Schema Information
# Schema version: 20110311170657
#
# Table name: announcements
#
#  id             :integer         not null, primary key
#  author         :string(255)
#  content        :text
#  created_at     :datetime
#  updated_at     :datetime
#  title          :string(255)
#  formatted_text :text
#

class Announcement < ActiveRecord::Base
  before_save :format
  
  validates_presence_of :author, :content, :title
  
  def self.for_front_page(limit = 3)
    limit(limit).order("updated_at desc")
  end
  
  private
    def format
      self.formatted_text = RedCloth.new(self.content,[:sanitize_html]).to_html
    end
    
end
