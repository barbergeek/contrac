require 'spec_helper'

describe "opportunities/show.html.erb" do
  before(:each) do
    @opportunity = assign(:opportunity, stub_model(Opportunity))
  end

  it "renders attributes in <p>" do
    render
  end
end
