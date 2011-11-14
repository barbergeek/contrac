require 'spec_helper'

describe ReportsController do

  describe "GET 'select'" do
    it "should be successful" do
      get 'select'
      response.should be_success
    end
  end

  describe "GET 'generate'" do
    it "should be successful" do
      get 'generate'
      response.should be_success
    end
  end

  describe "GET 'display'" do
    it "should be successful" do
      get 'display'
      response.should be_success
    end
  end

end
