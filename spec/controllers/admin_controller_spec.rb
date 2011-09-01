require 'spec_helper'

describe AdminController do

  describe "GET 'notify'" do
    it "should be successful" do
      get 'notify'
      response.should redirect_to(root_path)
    end
  end

end
