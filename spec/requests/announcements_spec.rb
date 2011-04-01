require 'spec_helper'
include Warden::Test::Helpers

describe "Announcements" do

  before (:each) do
    @user = Factory.create(:user)
    login_as @user
  end

  describe "GET /announcements" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get announcements_path
      response.should be_success
    end
  end
end
