class PortletsController < ApplicationController

  before_filter :require_login

  def portlet__opportunities_by_department(current_user,portlet_id)
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

    @portlet_id = portlet_id
    render_to_body :template => 'portlets/pie_chart'
  end

  def portlet__unawarded_opportunities_by_capture_phase(current_user,portlet_id)
    data = Opportunity.unawarded.with_capture_phase.capture_phase_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:xAxis][:categories] = data.keys
      f.options[:yAxis][:title][:text] = "Count"
      f.options[:title][:text] = 'Unawarded Opportunities by Capture Phase'
      f.options[:legend][:enabled] = false
    end

    @portlet_id = portlet_id
    render_to_body :template => 'portlets/column_chart'
  end

  def portlet__my_unawarded_opportunities_by_capture_phase(current_user,portlet_id)
    data = Opportunity.unawarded.for(current_user).with_capture_phase.capture_phase_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:xAxis][:categories] = data.keys
      f.options[:yAxis][:title][:text] = "Count"
      f.options[:title][:text] = 'My Unawarded Opportunities by Capture Phase'
      f.options[:legend][:enabled] = false
    end

    @portlet_id = portlet_id
    render_to_body :template => 'portlets/column_chart'
  end


  def portlet__unawarded_opportunities_by_input_status(current_user,portlet_id)
    data = Opportunity.unawarded.input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:xAxis][:categories] = data.keys
      f.options[:yAxis][:title][:text] = "Count"
      f.options[:title][:text] = 'Unawarded Opportunities by INPUT Status'
      f.options[:legend][:enabled] = false
    end

    @portlet_id = portlet_id
    render_to_body :template => 'portlets/column_chart'
  end

  def portlet__my_unawarded_opportunities_by_input_status(current_user,portlet_id)
    data = Opportunity.unawarded.for(current_user).input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:xAxis][:categories] = data.keys
      f.options[:yAxis][:title][:text] = "Count"
      f.options[:title][:text] = 'My Unawarded Opportunities'
      f.options[:legend][:enabled] = false
    end

    @portlet_id = portlet_id
    render_to_body :template => 'portlets/column_chart'
  end


  def portlet__all_opportunities_by_input_status(current_user,portlet_id)
    data = Opportunity.input_status_count
    @hc = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => data.values
      )
      f.options[:xAxis][:categories] = data.keys
      f.options[:yAxis][:title][:text] = "Count"
      f.options[:title][:text] = 'All Opportunities by INPUT Status'
      f.options[:legend][:enabled] = false
    end

    @portlet_id = portlet_id
    render_to_body :template => 'portlets/column_chart'
  end

  def portlet__announcements(*)
    announcements = Announcement.for_front_page
    render_to_body :template => 'portlets/announcements', :locals => {:title => "Announcements", :announcements => announcements}
  end

  def portlet__upcoming_opportunities(*)
    data = Opportunity.pre_rfp.program_and_rfp_date.limit(5).by_rfp_date
    render_to_body :template => 'portlets/table', :locals => {:title => "Upcoming Opportunities", :table => data }
  end

  def portlet__my_upcoming_opportunities(current_user,portlet_id)
    data = Opportunity.pre_rfp.program_and_rfp_date.for(current_user).limit(5).by_rfp_date
    render_to_body :template => 'portlets/table', :locals => {:title => "My Upcoming Opportunities", :table => data }
  end

  def portlet__recently_updated_opportunities(*)
    data = Opportunity.pre_rfp.program_and_update_date.recently_updated.limit(8).by_updated_desc
    render_to_body :template => 'portlets/table', :locals => {:title => "Recently Updated Opportunities", :table => data }
  end


  def portlet__table(*)
  end

  def portlet__text(*)
    render_to_body :template => 'portlets/text', :locals => {:title => "Text Test" }
  end

end

