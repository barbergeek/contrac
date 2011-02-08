module OpportunitiesHelper
  
  def input_opportunity_url(input_num)
    "http://www.input.com/index.cfm?fractal=opportunities.dsp.search.detail&PrdctCd=PFOIT&OppID=#{input_num}"
  end
  
end
