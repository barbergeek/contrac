module PortletsHelper
  
  def portlet(portlet)
    p=PortletsController.new
    p.send("portlet__#{portlet}",current_user)
  end

  def highchart_portlet(hc, options = {}, &block)
    block_to_partial('portlet/highchart', options.merge(:hc => hc), &block)
  end

end
