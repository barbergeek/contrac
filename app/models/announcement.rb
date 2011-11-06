class Announcement < ActiveRecord::Base
  before_save :format
  
  validates_presence_of :author, :content, :title
  
  def self.for_front_page(limit = 3)
    limit(limit).where("updated_at > ?",14.days.ago).order("updated_at desc")
  end
  
  
  private
    def format
      self.formatted_text = RedCloth.new(self.content,[:sanitize_html]).to_html
    end
    
end

# == Schema Information
#
# Table name: announcements
#
#  id             :integer         primary key
#  author         :string(255)
#  content        :text
#  created_at     :timestamp
#  updated_at     :timestamp
#  title          :string(255)
#  formatted_text :text
#

