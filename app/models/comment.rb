class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  before_create :set_comment_dt

  attr_accessible :content, :source, :commentable_id, :commentable_type, :commented_at

  validates_presence_of :content

  default_scope order('created_at desc')

  def self.by_createdate_desc
    order('created_at desc')
  end

  def comment_dt
    commented_at || created_at
  end

  private
    def set_comment_dt
      self.commented_at = created_at if commented_at.blank?
    end

end


# == Schema Information
#
# Table name: comments
#
#  id               :integer         primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  source           :string(255)
#  created_at       :timestamp
#  updated_at       :timestamp
#  commented_at     :timestamp
#

