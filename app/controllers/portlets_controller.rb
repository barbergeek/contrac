class PortletsController < ApplicationController

  def portlet__opportunities_by_department(*)
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

  def portlet__unawarded_opportunities_by_input_status(*)
    data = Opportunity.unawarded.input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:x_axis][:categories] = data.keys
      f.options[:y_axis][:title][:text] = "Count"
      f.options[:title][:text] = 'Unawarded Opportunities by INPUT Status'
      f.options[:legend][:enabled] = false
    end

    render_to_body :template => 'portlet/opportunities_by_input_status'
  end

  def portlet__my_unawarded_opportunities_by_input_status(current_user)
    data = Opportunity.unawarded.for(current_user).input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:x_axis][:categories] = data.keys
      f.options[:y_axis][:title][:text] = "Count"
      f.options[:title][:text] = 'My Unawarded Opportunities'
      f.options[:legend][:enabled] = false
    end

    render_to_body :template => 'portlet/opportunities_by_input_status'
  end


  def portlet__all_opportunities_by_input_status(*)
    data = Opportunity.input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:x_axis][:categories] = data.keys
      f.options[:y_axis][:title][:text] = "Count"
      f.options[:title][:text] = 'All Opportunities by INPUT Status'
      f.options[:legend][:enabled] = false
    end

    render_to_body :template => 'portlet/opportunities_by_input_status'
  end

  def portlet__upcoming_opportunities(*)
    @data = Opportunity.unawarded.select("id,program,rfp_release_date").limit(5).order("rfp_release_date asc")
  
    render_to_body :template => 'portlet/table', :locals => {:title => "Upcoming Opportunities", :table => @data }
  end

  def portlet__my_upcoming_opportunities(current_user)

    @data = Opportunity.unawarded.select("id,program,rfp_release_date").for(current_user).limit(5).order("rfp_release_date asc")
  
    render_to_body :template => 'portlet/table', :locals => {:title => "My Upcoming Opportunities", :table => @data }
  end

  def portlet__table(*)
  end

  def portlet__text(*)
    render_to_body :template => 'portlet/text', :locals => {:title => "Text Test" }
  end

end
