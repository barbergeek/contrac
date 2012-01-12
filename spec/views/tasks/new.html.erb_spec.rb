require 'spec_helper'

describe "tasks/new.html.erb" do
  before(:each) do
    assign(:task, stub_model(Task,
      :name => "MyString",
      :notes => "MyText",
      :owner => "",
      :status => "MyString",
      :assigned_by => ""
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path, :method => "post" do
      assert_select "input#task_name", :name => "task[name]"
      assert_select "textarea#task_notes", :name => "task[notes]"
      assert_select "input#task_owner", :name => "task[owner]"
      assert_select "input#task_status", :name => "task[status]"
      assert_select "input#task_assigned_by", :name => "task[assigned_by]"
    end
  end
end
