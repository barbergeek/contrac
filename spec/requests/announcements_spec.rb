require 'spec_helper'

describe "Announcements" do

  before (:each) do
    @user = FactoryGirl.create(:user, :password => "foo", :password_confirmation => "foo")
    integration_login @user, "foo"
  end

  describe "GET /announcements" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get announcements_path
      response.should be_success
    end
  end
end
