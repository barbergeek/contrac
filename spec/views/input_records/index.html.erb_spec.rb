require 'spec_helper'

describe "input_records/index.html.erb" do
  before(:each) do
    assign(:input_records, [
      stub_model(InputRecord),
      stub_model(InputRecord)
    ])
  end

  it "renders a list of input_records" do
    render
  end
end
