# == Schema Information
# Schema version: 20110217181137
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
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  
  attr_accessible :content, :source, :commentable_id, :commentable_type
  
  validates_presence_of :content
  
end
