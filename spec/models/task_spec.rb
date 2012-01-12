require 'spec_helper'

describe Task do
  pending "add some examples to (or delete) #{__FILE__}"
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

