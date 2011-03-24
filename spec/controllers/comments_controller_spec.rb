require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end


end
