class User < ActiveRecord::Base
  has_secure_password
  
  has_many :opportunities, :foreign_key => :business_developer_id
  has_many :proposals, :foreign_key => :capture_manager_id
  has_many :watched_opportunities
  has_many :watched, :through => :watched_opportunities, :source => :opportunity

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :name, :initials, :opportunities
  
  validates_presence_of :password, :on => :create

  # Handle "remember me"
  before_create { generate_token(:auth_token) }

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
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
end




# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  email            :string(255)     default(""), not null
#  created_at       :datetime
#  updated_at       :datetime
#  roles_mask       :integer
#  name             :string(255)
#  initials         :string(255)
#  color            :string(255)
#  last_notified_at :datetime
#  password_digest  :string(255)
#

