# == Schema Information
# Schema version: 20110527014037
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  roles_mask           :integer
#  name                 :string(255)
#  initials             :string(255)
#  color                :string(255)
#  last_notified_at     :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable, :registerable,
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :opportunities, :foreign_key => :business_developer_id
  has_many :proposals, :foreign_key => :capture_manager_id
  has_many :watched_opportunities
  has_many :watched, :through => :watched_opportunities, :source => :opportunity

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :name, :initials, :opportunities
  
  # Roles
  ROLES = %w[admin business_developer bd_manager capture_manager senior_manager]
  BD_ROLES = %w[business_developer bd_manager]
  CAPTURE_ROLES = BD_ROLES + %w[capture_manager]
  
  def self.by_initials
    order("initials")
  end
    
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def admin?
    roles.include?("admin")
  end
  
  def bd?
    roles.include?("business_developer")
  end
  
  def capture?
    roles.include?("business_developer") or roles.include?("capture_manager")
  end
  
  def capture_manager?
    roles.include?("capture_manager")
  end
  
end
