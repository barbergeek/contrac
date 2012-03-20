require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
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
#  recently_viewed              :string(255)
#

