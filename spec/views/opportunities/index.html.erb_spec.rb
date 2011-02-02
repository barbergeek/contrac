require 'spec_helper'

describe "opportunities/index.html.erb" do
  before(:each) do
    assign(:opportunities, [
      stub_model(Opportunity),
      stub_model(Opportunity)
    ])
  end

  it "renders a list of opportunities" do
    render
  end
end
