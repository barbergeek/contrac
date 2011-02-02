require 'spec_helper'

describe "opportunities/edit.html.erb" do
  before(:each) do
    @opportunity = assign(:opportunity, stub_model(Opportunity))
  end

  it "renders the edit opportunity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => opportunity_path(@opportunity), :method => "post" do
    end
  end
end
