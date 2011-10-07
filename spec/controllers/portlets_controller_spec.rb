require 'spec_helper'

describe PortletsController do

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

#  describe "GET 'highchart'" do
#    it "should be successful" do
#      get 'highchart'
#      response.should be_success
#    end
#  end
#
#  describe "GET 'table'" do
#    it "should be successful" do
#      get 'table'
#      response.should be_success
#    end
#  end
#
#  describe "GET 'text'" do
#    it "should be successful" do
#      get 'text'
#      response.should be_success
#    end
#  end

end
