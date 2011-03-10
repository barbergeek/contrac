module PortletHelper

  def highchart_portlet(hc, options = {}, &block)
    block_to_partial('portlet/highchart', options.merge(:hc => hc), &block)
  end
  
  def portlet(portlet)
    p = PortletController.new
    p.send(portlet)
  end
  
end
