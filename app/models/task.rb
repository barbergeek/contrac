class Task < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :opportunity
  belongs_to :assigned_by, class_name: "User"

  attr_accessible :name, :notes, :owner_id, :opportunity_id, :status, :due_at, :closed_at, :assigned_by_id

  STATUSES = %w[Open Closed Cancelled]

  validates_presence_of :name

end


# == Schema Information
#
# Table name: tasks
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  notes          :text
#  owner_id       :integer
#  opportunity_id :integer
#  status         :string(255)
#  due_at         :datetime
#  closed_at      :datetime
#  assigned_by_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

