require 'will_paginate/array'

class OpportunitiesController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :require_login

  # GET /opportunities
  # GET /opportunities.xml
  def index
    #store_location

    setup_filters

    @searchstring = session[:search] || ""

    opp = session[:show_ignored] ? Opportunity.unscoped : Opportunity
    
    opp = opp.exclude_outcomes(@outcome_exclusions) unless @outcome_exclusions.empty?

    opportunity_list = opp.
      where(@filters).
      where(@owner_filters).
      includes([:business_developer, :capture_manager, :watchers]).
      order("#{sort_column} #{sort_direction}").
      search(@searchstring)
    
    @opportunities = opportunity_list.
      paginate(:page => params[:page], :per_page => 20)

    if @opportunities.empty? && opportunity_list # if no opportunities, make sure we paginate from page 1
      params[:page] = 1
      @opportunities = opportunity_list.paginate(:page => params[:page], :per_page => 20)
    end

    session[:opportunity_id_list] = opportunity_list.map {|i| i.id}
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opportunities }
      format.js { render :layout => false, :content_type => 'text/html' }
    end
  end

  def dashboard
    #store_location
    
  end

  def my
    session[:search] = params[:search]
    session[:filters] ||= {}
    session[:owner_filters] = "business_developer_id = #{current_user.id} or capture_manager_id = #{current_user.id} or watched_opportunities.user_id = #{current_user.id}"
    redirect_to opportunities_path
  end

  def all
    session[:search] = params[:search]
    session[:filters] ||= {}
    session[:owner_filters] = nil
    session[:exclusions] ||= {}
    redirect_to opportunities_path
  end

  def filter
    if params[:button_action] == "Clear"
      session[:search] = ""
      session[:filters] = {}
      session[:owner_filters] = nil
      session[:show_ignored] = false
      session[:exclusions] = {}
    else
      session[:search] = params[:search]
      session[:filters] = params[:filters] || {}
      session[:owner_filters] = nil
      if params[:owners]
        session[:owner_filters] = "business_developer_id = #{params[:owners][:owner_id].first} or capture_manager_id = #{params[:owners][:owner_id].first}"
      end
      session[:show_ignored] = params[:ignore]
      session[:exclusions] = params[:exclusions]
    end
    redirect_back_or_to opportunities_path
  end

  # GET /opportunities/1
  # GET /opportunities/1.xml
  def show

    @opportunity = Opportunity.find(params[:id])
    @comments = @opportunity.comments
    @commentable = @opportunity
    @owners = User.by_initials.keep_if {|user| user.capture? }
    @bders = User.by_initials.keep_if {|user| user.bd? }

    respond_to do |format|
      format.html { render 'edit' } # render the edit page in readonly mode
      format.xml  { render :xml => @opportunity }
      format.js
    end
  end

  # GET /opportunities/new
  # GET /opportunities/new.xml
  def new

    @opportunity = Opportunity.new
    @comments = @opportunity.comments
    @commentable = @opportunity
    @owners = User.by_initials.keep_if {|user| user.capture? }
    @bders = User.by_initials.keep_if {|user| user.bd? }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @opportunity }
      format.js { render :layout => false, :content_type => 'text/html' }
    end
  end

  # GET /opportunities/1/edit
  def edit

    @opportunity = Opportunity.find(params[:id])
    @comments = @opportunity.comments
    @commentable = @opportunity
    @owners = User.by_initials.keep_if {|user| user.capture? }
    @bders = User.by_initials.keep_if {|user| user.bd? }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @opportunity }
      format.js { render :layout => false, :content_type => 'text/html' }
    end

  end

  # POST /opportunities
  # POST /opportunities.xml
  def create
    @opportunity = Opportunity.new(params[:opportunity])

    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to(@opportunity, :notice => 'Opportunity was successfully created.') }
        format.xml  { render :xml => @opportunity, :status => :created, :location => @opportunity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /opportunities/1
  # PUT /opportunities/1.xml
  def update
    @opportunity = Opportunity.find(params[:id])

    respond_to do |format|
      if @opportunity.update_attributes(params[:opportunity])
#        unless params[:opportunity][:comment][:content].blank?
#          @opportunity.comments << Comment.new(:content => "#{params[:opportunity][:comment][:content]}",
#              :source => current_user.initials)
#          @opportunity.save!
#        end
        format.html { redirect_to(@opportunity, :notice => 'Opportunity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.xml
  def destroy
    @opportunity = Opportunity.unscoped.find(params[:id])
    if @opportunity.ignored?
      @opportunity.recover
      flash[:notice] = "Opportunity recovered"
    else
      @opportunity.destroy
      flash[:notice] = "Opportunity ignored"
    end
    
    respond_to do |format|
      format.html { redirect_to(opportunities_url) }
      format.xml  { head :ok }
    end
  end

  def calendar
    store_location
    setup_filters

  	@rows = 5
  	@columns = 3 # must divide into 24

    @start = Date.today.beginning_of_quarter
    @end = @start.advance(:months => (@rows*@columns)).advance(:days => -1)

    if params[:order_by] == "due_date"
      @opportunities = Opportunity.calendar.where(@filters).where(@owner_filters).includes([:business_developer, :capture_manager, :watchers]).where("rfp_due_date between ? and ?",@start,@end).order("rfp_due_date")
      @order_by = :due_date
    else
      @opportunities = Opportunity.calendar.where(@filters).where(@owner_filters).includes([:business_developer, :capture_manager, :watchers]).where("rfp_release_date between ? and ?",@start,@end).order("rfp_release_date")
      @order_by = :release_date
    end

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @opportunities }
       format.js { render :layout => false, :content_type => 'text/html' }
     end
  end

  def watch
    @opportunity = Opportunity.find(params[:id])
    @opportunity.toggle_watch(current_user)

    respond_to do |format|
      format.html { redirect_to(opportunities_path)}
      format.xml { head :ok }
      format.js
    end
  end

  def own
    @opportunity = Opportunity.find(params[:id])
    @opportunity.own(current_user)

    respond_to do |format|
      format.html { redirect_to(opportunities_path)}
      format.xml { head :ok }
      format.js
    end
  end

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
    headers['Cache-Control'] = ''
    @records = Opportunity.find(:all)
    @users = User.select("id,name,email,initials")
  end
  
  private
    def sort_column
      (%w[users.initials]+Opportunity.column_names).include?(params[:sort]) ? params[:sort] : "program"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def setup_filters
      @filters = session[:filters] || {}
      @dept_filters = @filters[:department] || {}
      @agency_filters = @filters[:agency] || {}
      @input_status_filters = @filters[:input_status] || {}
      @capture_phase_filters = @filters[:capture_phase] || {}
      @owner_filters = session[:owner_filters] || {}
      @show_ignored = session[:show_ignored] || false
      @priority_filters = @filters[:priority] || {}
      @exclude_filters = session[:exclusions] || {}
      @outcome_exclusions = @exclude_filters[:outcome] || {}

      @departments = Opportunity.find(:all, :select => "distinct department")
      @agencies = Opportunity.find(:all, :select => "distinct agency", :conditions => "agency is not null and agency <> ''")
      @input_statuses = Opportunity.find(:all, :select => "distinct input_status")
      @capture_phases = Opportunity::PHASES
      @priorities = Opportunity::PRIORITIES
      @owners = User.find(:all).keep_if {|user| user.capture? }

    end

end

