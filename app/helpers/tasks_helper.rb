module TasksHelper

  def task_status_class(status)
    case status
    when "Open"
      "success"
    when "Closed"
      "notice"
    when "Cancelled"
      ""
    end
  end
end
