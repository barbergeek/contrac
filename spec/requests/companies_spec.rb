require 'spec_helper'

describe "Companies" do

  before (:each) do
    @user = Factory(:user, :password => "foo", :password_confirmation => "foo")
    integration_login @user, "foo"
  end

  describe "GET /companies" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit companies_path
      current_path.should == companies_path
    end
  end
end
