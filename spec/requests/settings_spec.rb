require 'spec_helper'

describe "Settings" do

  before (:each) do
    @user = FactoryGirl.create(:user, :password => "foo", :password_confirmation => "foo")
    integration_login @user, "foo"
  end

  describe "GET /settings" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit settings_path
      current_path.should == settings_path
    end
  end
end
