module ApplicationHelper

  def title(title)
    @title = title || "CONtrack"
  end

  def is_active_tab?(*tabs)
    active = nil
    tabs.each do |tab|
      active = "active" if controller.controller_name == tab.to_s
    end
    active
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "ui-icon ui-icon-triangle-1-" + (sort_direction == "asc" ? "n" : "s") : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    title += content_tag(:div,"",{:class => css_class}) if (column == sort_column)
    link_to title.html_safe , {:sort => column, :direction => direction}
  end

  # for pagination with Twitter Bootstrap
  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end

  # Only need this helper once, it will provide an interface to convert a block into a partial.
    # 1. Capture is a Rails helper which will 'capture' the output of a block into a variable
    # 2. Merge the 'body' variable into our options hash
    # 3. Render the partial with the given options hash. Just like calling the partial directly.
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
#    concat(render(:partial => partial_name, :locals => options), block.binding)
    render(:partial => partial_name, :locals => options)
  end

#  # Create as many of these as you like, each should call a different partial
#    # 1. Render 'shared/rounded_box' partial with the given options and block content
#  def rounded_box(title, options = {}, &block)
#    block_to_partial('shared/rounded_box', options.merge(:title => title), &block)
#  end
#
#  # Sample helper #2
#  def un_rounded_box(title, options = {}, &block)
#    block_to_partial('shared/un_rounded_box', options.merge(:title => title), &block)
#  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def redirect_back_or_path(default)
    session[:return_to] || default
  end


  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end

  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end


end
