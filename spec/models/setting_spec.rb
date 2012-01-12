require 'spec_helper'

describe Setting do
  it "should store an arbitrary key" do
    Setting.test.should be_nil    # should not exist
    Setting.test = "abc"          # set some value
    Setting.test.should == "abc"  # now should have that value
  end
  
  it "should let me change the value" do
    Setting.test = "abc"
    Setting.test.should == "abc"
    Setting.test = "123"
    Setting.test.should == "123"
  end
  
  context "should store other types of objects" do
    it "stores arrays" do
      x = ['a', 123, :test]
      Setting.test = x
      Setting.test.should == x
    end

    it "stores objects" do
      x = Factory(:opportunity)
      Setting.test = x
      Setting.test.should == x
    end
  end
  
end

# == Schema Information
#
# Table name: settings
#
#  id         :integer         not null, primary key
#  key        :string(255)
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

