class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :opportunities, :foreign_key => :business_developer_id
  has_many :proposals, :foreign_key => :capture_manager_id
  has_many :watched_opportunities
  has_many :watched, :through => :watched_opportunities, :source => :opportunity
  has_many :tasks, foreign_key: :owner_id
  has_many :tasks_assigned, foreign_key: :assigned_by, source: :tasks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :name, :initials, :opportunities, :tasks, :tasks_assigned

  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  # Roles
  ROLES = %w[admin business_developer bd_manager capture_manager senior_manager registration_manager]
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

  def can_change_registration?(opportunity)
    roles.include?("registration_manager") or admin? or (id == opportunity.registered_by_id)
  end

end






# == Schema Information
#
# Table name: users
#
#  id                           :integer         not null, primary key
#  email                        :string(255)     default(""), not null
#  created_at                   :datetime
#  updated_at                   :datetime
#  roles_mask                   :integer
#  name                         :string(255)
#  initials                     :string(255)
#  color                        :string(255)
#  last_notified_at             :datetime
#  crypted_password             :string(255)
#  salt                         :string(255)
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#

