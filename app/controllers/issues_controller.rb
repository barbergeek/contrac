class IssuesController < ApplicationController

  def index
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(params[:issue])
    @issue.notes += "\n\nReported by: #{@issue.submitted_by}"
    if @issue.save
      flash[:notice] = "Issue created. Thank you for reporting a #{@issue.labels}!"
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
