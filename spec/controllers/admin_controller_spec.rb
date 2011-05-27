require 'spec_helper'

describe AdminController do

  describe "GET 'notify'" do
    it "should be successful" do
      get 'notify'
      response.should be_success
    end
  end

end
