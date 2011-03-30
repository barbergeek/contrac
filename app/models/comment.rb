# == Schema Information
# Schema version: 20110330043215
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  source           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  commented_at     :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  before_create :set_comment_dt
  
  attr_accessible :content, :source, :commentable_id, :commentable_type, :commented_at
  
  validates_presence_of :content
  
  def comment_dt
    commented_at || created_at
  end
  
  private
    def set_comment_dt
      commented_at = created_at unless commented_at
    end
  
end
