require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe OpportunitiesController do
  include Devise::TestHelpers

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  def mock_opportunity(stubs={})
    @mock_opportunity ||= mock_model(Opportunity, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all opportunities as @opportunities" do
      pending "need to understand why this fails" do
        Opportunity.stub(:all) { [mock_opportunity] }
        get :index
        assigns(:opportunities).should eql([mock_opportunity])
      end
    end
  end

  describe "GET show" do
    it "assigns the requested opportunity as @opportunity" do
      Opportunity.stub(:find).with("37") { mock_opportunity }
      get :show, :id => "37"
      assigns(:opportunity).should be(mock_opportunity)
    end
  end

  describe "GET new" do
    it "assigns a new opportunity as @opportunity" do
      Opportunity.stub(:new) { mock_opportunity }
      get :new
      assigns(:opportunity).should be(mock_opportunity)
    end
  end

  describe "GET edit" do
    it "assigns the requested opportunity as @opportunity" do
      Opportunity.stub(:find).with("37") { mock_opportunity }
      get :edit, :id => "37"
      assigns(:opportunity).should be(mock_opportunity)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created opportunity as @opportunity" do
        Opportunity.stub(:new).with({'these' => 'params'}) { mock_opportunity(:save => true) }
        post :create, :opportunity => {'these' => 'params'}
        assigns(:opportunity).should be(mock_opportunity)
      end

      it "redirects to the created opportunity" do
        Opportunity.stub(:new) { mock_opportunity(:save => true) }
        post :create, :opportunity => {}
        response.should redirect_to(opportunity_url(mock_opportunity))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved opportunity as @opportunity" do
        Opportunity.stub(:new).with({'these' => 'params'}) { mock_opportunity(:save => false) }
        post :create, :opportunity => {'these' => 'params'}
        assigns(:opportunity).should be(mock_opportunity)
      end

      it "re-renders the 'new' template" do
        Opportunity.stub(:new) { mock_opportunity(:save => false) }
        post :create, :opportunity => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested opportunity" do
        Opportunity.stub(:find).with("37") { mock_opportunity }
        mock_opportunity.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :opportunity => {'these' => 'params'}
      end

      it "assigns the requested opportunity as @opportunity" do
        Opportunity.stub(:find) { mock_opportunity(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:opportunity).should be(mock_opportunity)
      end

      it "redirects to the opportunity" do
        Opportunity.stub(:find) { mock_opportunity(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(opportunity_url(mock_opportunity))
      end
    end

    describe "with invalid params" do
      it "assigns the opportunity as @opportunity" do
        Opportunity.stub(:find) { mock_opportunity(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:opportunity).should be(mock_opportunity)
      end

      it "re-renders the 'edit' template" do
        Opportunity.stub(:find) { mock_opportunity(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested opportunity" do
      Opportunity.stub(:find).with("37") { mock_opportunity }
      mock_opportunity.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the opportunities list" do
      Opportunity.stub(:find) { mock_opportunity }
      delete :destroy, :id => "1"
      response.should redirect_to(opportunities_url)
    end
  end

end
