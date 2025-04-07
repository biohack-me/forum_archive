class Rack::Attack

  ### Throttle config (prevents user for getting further responses) ###

  # prevent people/bots from hitting all the moved vanilla URLs overly quickly
  throttle('redirect_throttling', limit: 5, period: 1.minute) do |req|
    if (req.path =~ /index.php/) 
      req.ip
    end
  end

  ### Custom Throttle Response ###

  # By default, Rack::Attack returns an HTTP 429 for throttled responses,
  # which is just fine.
  #
  # If you want to return 503 so that the attacker might be fooled into
  # believing that they've successfully broken your app (or you just want to
  # customize the response), then uncomment these lines.
  # self.throttled_responder = lambda do |req|
  #  [ 503,  # status
  #    {},   # headers
  #    ['']] # body
  # end

end

ActiveSupport::Notifications.subscribe("throttle.rack_attack") do |name, start, finish, request_id, payload|
  req = payload[:request]
  if req.env['rack.attack.matched'] == "redirect_throttling"
    Rails.logger.warn "************ Vanilla URL redirect rate limit exceeded!\n************\tpath: #{req.path}\n************\tquery: #{req.params}"
  end
end