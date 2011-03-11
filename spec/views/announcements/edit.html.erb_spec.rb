require 'spec_helper'

describe "announcements/edit.html.erb" do
  before(:each) do
    @announcement = assign(:announcement, stub_model(Announcement,
      :author => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit announcement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => announcements_path(@announcement), :method => "post" do
      assert_select "input#announcement_author", :name => "announcement[author]"
      assert_select "textarea#announcement_content", :name => "announcement[content]"
    end
  end
end
