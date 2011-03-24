require 'spec_helper'

describe "Opportunities" do
  include Devise::TestHelpers

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  describe "GET /opportunities" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get opportunities_path
      response.status.should be(200)
    end
  end
end
