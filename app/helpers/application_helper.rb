module ApplicationHelper
  
  def title(title)
    @title = title || "Contac"
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "ui-icon ui-icon-triangle-1-" + (sort_direction == "asc" ? "n" : "s") : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    title += content_tag(:div,"",{:class => css_class}) if (column == sort_column)
    link_to title.html_safe , {:sort => column, :direction => direction}
  end
  
end
