class ReportsController < ApplicationController
  
  REPORTS = %w(opportunity_tracker test_report).map {|r| [r.titleize, r]}
  
  def select
    @reports = REPORTS
  end

  def generate
  end

  def display
  end

end
