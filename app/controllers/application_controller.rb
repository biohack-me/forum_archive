class ApplicationController < ActionController::Base

  def routing_error
    logger.warn "************ unknown path requested: #{params[:p]}"
    respond_to do |format|
      format.html { render '404', status: 404 }
      format.any  { redirect_to action: 'routing_error', format: 'html' }
    end
  end

end
