class PagesController < ApplicationController
  def home
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
    
    @data = Opportunity.unawarded.input_status_count
    @hc2 = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(
        :type => 'column',
        :name => 'Count',
        :data => @data.values
      )
      f.options[:x_axis][:categories] = @data.keys
      f.options[:title][:text] = 'Opportunities by INPUT Status'
    end
    
  end

  def about
  end

  def help
  end

  def contact
  end

end
