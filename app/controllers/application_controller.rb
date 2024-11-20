class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound,   with: -> { routing_error }
  rescue_from ActionController::RoutingError, with: -> { routing_error } # raised in redirect_controller

  def routing_error
    logger.warn "************ unknown path requested: #{params[:p]}"
    begin
      respond_to do |format|
        format.html { render '404', status: 404 }
      end
    rescue
      return redirect_to controller: 'application', action: 'bad_format_routing_error', format: :html
    end
  end

  # the old redirect in routing_error, above, was passing additional params
  # along that was causing additional routing errors.
  # e.g., the path '/discussions/feed.rss' would try to route to
  # `{:action=>"routing_error", :controller=>"discussions", :format=>"html", :id=>"feed"}`,
  # and the :id didn't match any route (even after correcting controller name)
  def bad_format_routing_error
    redirect_to action: 'routing_error', format: 'html'
  end

end
