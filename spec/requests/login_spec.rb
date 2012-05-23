require 'spec_helper'

describe 'testing login' do
  
  describe "before logging in" do
    it "should contain 'Login' before logging in" do
      visit root_path
      page.should have_content("Login")
    end
  
    it "should redirect back to the requested page after login" do
      visit root_path
      page.should have_content("Login")
    
      visit opportunities_path
      page.should have_content("First login")
      click_link "Login"

      password = "foobar"
      user = FactoryGirl.create(:user, :password => password, :password_confirmation => password)

      fill_in "Email",     :with => user.email
      fill_in "Password",  :with => password
      click_button 'Login'
    
      page.should have_content("Login successful")
      current_path.should == opportunities_path
    end
  end
end
