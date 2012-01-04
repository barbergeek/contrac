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
  
  describe "filters/searching" do
    it "should return a list of opportunities when returning multiples" do
      opp = Factory.create(:opportunity, program: "Program1")
      opp2 = Factory.create(:opportunity, program: "Program2")
      visit opportunities_path
      #click_on "Search Filters"
      within ("#opportunity-filter") do
        fill_in "search", with: "Program"
        click_on "Search"
      end
      current_path.should == opportunities_path
      page.should have_content("Program1")
      page.should have_content("Program2")
    end
    
    it "should go to the opportunity page when returning only one" do
        opp = Factory.create(:opportunity, program: "Program1")
        opp2 = Factory.create(:opportunity, program: "Don't find me")
        visit opportunities_path
        #click_on "Search Filters"
        within ("#opportunity-filter") do
          fill_in "search", with: "Program"
          click_on "Search"
        end
        current_path.should == opportunity_path(opp)
      end
      
  end
end
