require 'spec_helper'

describe "tasks/edit.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "MyString",
      :notes => "MyText",
      :owner => "",
      :status => "MyString",
      :assigned_by => ""
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path(@task), :method => "post" do
      assert_select "input#task_name", :name => "task[name]"
      assert_select "textarea#task_notes", :name => "task[notes]"
      assert_select "input#task_owner", :name => "task[owner]"
      assert_select "input#task_status", :name => "task[status]"
      assert_select "input#task_assigned_by", :name => "task[assigned_by]"
    end
  end
end
