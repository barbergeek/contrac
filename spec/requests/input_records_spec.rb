require 'spec_helper'
include Warden::Test::Helpers

describe "InputRecords" do

  before (:each) do
    @user = Factory.create(:user)
    login_as @user
  end

  describe "GET /input_records" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get input_records_path
      response.status.should be(200)
    end
  end
end
