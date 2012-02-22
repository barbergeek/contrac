module OpportunitiesHelper

  def input_opportunity_url(input_num)
    "https://iq.govwin.com/index.cfm?fractal=opportunities.dsp.search.detail&PrdctCd=PFOIT&OppID=#{input_num}"
  end

  def link_to_input(input_num, options = {})
    if input_num.blank?
      ""
    else
      link_to input_num, input_opportunity_url(input_num), options
    end
  end

  def next_opportunity_link(current)
    current_index = session[:opportunity_id_list].index(current)
    if current != session[:opportunity_id_list].last
      link_to "Next", edit_opportunity_url(session[:opportunity_id_list][current_index+1])
    else
      ("&nbsp;"*4).html_safe
    end
  end

  def previous_opportunity_link(current)
    current_index = session[:opportunity_id_list].index(current)
    if current != session[:opportunity_id_list].first
      link_to "Previous", edit_opportunity_url(session[:opportunity_id_list][current_index-1])
    else
      ("&nbsp;"*8).html_safe
    end
  end

  def first_opportunity_link(current)
    link_to "First", edit_opportunity_url(session[:opportunity_id_list].first)
  end

  def last_opportunity_link(current)
    link_to "Last", edit_opportunity_url(session[:opportunity_id_list].last)
  end

end
