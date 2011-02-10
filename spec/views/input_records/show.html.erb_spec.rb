require 'spec_helper'

describe "input_records/show.html.erb" do
  before(:each) do
    @input_record = assign(:input_record, stub_model(InputRecord))
  end

  it "renders attributes in <p>" do
    render
  end
end
