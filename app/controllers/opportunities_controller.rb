class OpportunitiesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_user!
  
  # GET /opportunities
  # GET /opportunities.xml
  def index
    setup_filters
    
   @opportunities = Opportunity.where(@filters).paginate :include => [:owner, :watchers], 
      :page => params[:page], :per_page => 20, 
      :order => "#{sort_column} #{sort_direction}"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opportunities }
      format.js { render :layout => false, :content_type => 'text/html' }
    end
  end
  
  def my
    session[:filters] ||= {}
    session[:filters] = session[:filters].merge({:owner_id => current_user.id.to_s}) if current_user.capture?
    redirect_to opportunities_path
  end
  
  def all
    session[:filters] ||= {}
    session[:filters].delete(:owner_id)
    redirect_to opportunities_path
  end
  
  def filter
    session[:filters] = params[:filters] || {}
    redirect_to opportunities_path
  end

  # GET /opportunities/1
  # GET /opportunities/1.xml
  def show
    @opportunity = Opportunity.find(params[:id])
    @comments = @opportunity.comments
    @commentable = @opportunity
        
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
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy

    respond_to do |format|
      format.html { redirect_to(opportunities_url) }
      format.xml  { head :ok }
    end
  end
  
  def calendar
    
    setup_filters

  	@rows = 5
  	@columns = 3 # must divide into 24

    @start = Date.today.beginning_of_quarter
    @end = @start.advance(:months => (@rows*@columns)).advance(:days => -1)
    
    @opportunities = Opportunity.calendar.where(@filters).where("rfp_release_date between ? and ?",@start,@end).order("rfp_release_date")

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @opportunities }
       format.js { render :layout => false, :content_type => 'text/html' }
     end
  end
  
  def watch
    @opportunity = Opportunity.find(params[:id])
    if @opportunity.watched_by?(current_user)
      @opportunity.watchers -= [current_user]
    else
      @opportunity.watchers << current_user
    end
    @opportunity.save!
    
    respond_to do |format|
      format.html { redirect_to(opportunities_path)}
      format.xml { head :ok }
      format.js
    end
  end
  
  def own
    @opportunity = Opportunity.find(params[:id])
    @opportunity.owner = current_user
    @opportunity.save!
    
    respond_to do |format|
      format.html { redirect_to(opportunities_path)}
      format.xml { head :ok }
      format.js
    end
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
      @owner_filters = @filters[:owner_id] || {}

      @departments = Opportunity.find(:all, :select => "distinct department")
      @agencies = Opportunity.find(:all, :select => "distinct agency", :conditions => "agency is not null and agency <> ''")
      @input_statuses = Opportunity.find(:all, :select => "distinct input_status")
      @capture_phases = Opportunity::PHASES
      @owners = User.find(:all).keep_if {|user| user.capture? }
      
    end
end
