require "spec_helper"

describe InputRecordsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/input_records" }.should route_to(:controller => "input_records", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/input_records/new" }.should route_to(:controller => "input_records", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/input_records/1" }.should route_to(:controller => "input_records", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/input_records/1/edit" }.should route_to(:controller => "input_records", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/input_records" }.should route_to(:controller => "input_records", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/input_records/1" }.should route_to(:controller => "input_records", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/input_records/1" }.should route_to(:controller => "input_records", :action => "destroy", :id => "1")
    end

  end
end
