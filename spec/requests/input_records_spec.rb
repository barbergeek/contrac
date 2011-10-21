require 'spec_helper'

describe "InputRecords" do

  before (:each) do
    @user = Factory.create(:user, :password => "foo", :password_confirmation => "foo")
    integration_login @user, "foo"
  end

  describe "GET /input_records" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit input_records_path
      current_path.should == input_records_path
    end
  end
end
