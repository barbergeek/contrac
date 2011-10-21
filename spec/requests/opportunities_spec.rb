require 'spec_helper'

describe "Opportunities" do

  before (:each) do
    @user = Factory.create(:user, :password => "foo", :password_confirmation => "foo")
    integration_login @user, "foo"
  end

  describe "GET /opportunities" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit opportunities_path
      current_path.should == opportunities_path
    end
    
    it "should show the opportunities list" do
      opp = Factory.create(:opportunity)
      visit opportunities_path
      #save_and_open_page
      page.should have_content(opp.program)
    end
    
  end
end
