module OpportunitiesHelper
  
  def input_opportunity_url(input_num)
    "http://www.input.com/index.cfm?fractal=opportunities.dsp.search.detail&PrdctCd=PFOIT&OppID=#{input_num}"
  end
  
  def link_to_input(input_num, options = {})
    if input_num.blank?
      ""
    else
      link_to input_num, input_opportunity_url(input_num), options
    end
  end
  
  
end
