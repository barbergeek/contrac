require 'spec_helper'

describe "Testing Pages" do
  
  describe "GET /" do
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_path
      response.status.should be(200)
    end
    
    it "should display the dashboard after logging in" do
      
      # stick an announcement on the dashboard to have something to look for
      Factory.create(:announcement)
      
      #integration_login Factory.create(:user)
#      visit root_path
      user = Factory.create(:user, :password => "foobar", :password_confirmation => "foobar")
      integration_login user, "foobar"

      page.should have_content("Login successful")
      page.should have_content("Logout")
      page.should have_content("Announcements")

    end
  end
end
