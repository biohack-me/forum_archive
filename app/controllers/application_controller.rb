class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound,   with: -> { routing_error }
  rescue_from ActionController::RoutingError, with: -> { routing_error } # raised in redirect_controller

  def routing_error
    logger.warn "************ unknown path requested: #{params[:p]}"
    respond_to do |format|
      format.html { render '404', status: 404 }
      format.any  { redirect_to action: 'routing_error', format: 'html' }
    end
  end

end
