require 'spec_helper'

describe "input_records/new.html.erb" do
  before(:each) do
    assign(:input_record, stub_model(InputRecord).as_new_record)
  end

  it "renders new input_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => input_records_path, :method => "post" do
    end
  end
end
