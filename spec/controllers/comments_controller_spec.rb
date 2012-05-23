require 'spec_helper'

describe CommentsController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    login_user @user
  end


end
