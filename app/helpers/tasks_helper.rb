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

  def get_upcoming_tasks
    @upcoming_tasks = Task.my_upcoming(current_user).limit(7)
  end

  def task_header(t)
    if t.new_record?
      "New Task"
    else
      ((t.opportunity.acronym.blank? ? t.opportunity.program : t.opportunity.acronym)  + " [" + link_to('Go', t.opportunity) +"]").html_safe
    end
  end
end
