module PortletsHelper
  
  def portlet(portlet)
    @portlet_id ||= 0
    @portlet_id += 1

    p=PortletsController.new
    p.send("portlet__#{portlet}",current_user,@portlet_id)
  end

  def highchart_portlet(hc, options = {}, &block)
    block_to_partial('portlets/highchart', options.merge(:hc => hc), &block)
  end

end
