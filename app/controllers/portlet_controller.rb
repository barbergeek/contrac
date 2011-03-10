class PortletController < ApplicationController
  before_filter :authenticate_user!
  
  def opportunities_by_department
    data = Opportunity.unawarded.department_count
    @hc = LazyHighCharts::HighChart.new('pie') do |f|
      series = {
        :type => 'pie',
        :data => data.to_a
      }
      f.series(series)
      f.options[:title][:text] = 'Opportunities by Department'
    f.plot_options(:pie => {
        :allowPointSelect => true,
        :cursor => "pointer"
      })
    end
    
    render_to_body :template => 'portlet/opportunities_by_department'
  end

  def opportunities_by_input_status
    data = Opportunity.unawarded.input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:x_axis][:categories] = data.keys
      f.options[:y_axis][:title][:text] = "Count"
      f.options[:title][:text] = 'Opportunities by INPUT Status'
    end

    render_to_body :template => 'portlet/opportunities_by_input_status'
  end
  
  def upcoming_opportunities
    @data = Opportunity.unawarded.select("id,program,rfp_release_date").limit(5).order("rfp_release_date asc")
    
    render_to_body :template => 'portlet/table', :locals => {:title => "Upcoming Opportunities", :table => @data }
  end

  def my_upcoming_opportunities

    @data = Opportunity.unawarded.select("id,program,rfp_release_date").for_who(session[:current_user].id).limit(5).order("rfp_release_date asc")
    
    render_to_body :template => 'portlet/table', :locals => {:title => "My Upcoming Opportunities for #{current_user.name}", :table => @data }
  end
  
  def table
  end

  def text
    render_to_body :template => 'portlet/text', :locals => {:title => "Text Test" }
  end

end
