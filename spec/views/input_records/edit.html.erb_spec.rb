require 'spec_helper'

describe "input_records/edit.html.erb" do
  before(:each) do
    @input_record = assign(:input_record, stub_model(InputRecord))
  end

  it "renders the edit input_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => input_record_path(@input_record), :method => "post" do
    end
  end
end
