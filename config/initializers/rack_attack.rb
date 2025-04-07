class Rack::Attack

  # see: https://github.com/rack/rack-attack/issues/145
  class Request < ::Rack::Request
    def remote_ip
      @remote_ip ||= (env['action_dispatch.remote_ip'] || env['HTTP_X_FORWARDED_FOR'] || ip).to_s
    end
  end

  ### Throttle config (prevents user for getting further responses) ###

  # prevent people/bots from hitting all the moved vanilla URLs overly quickly
  throttle('redirect_throttling', limit: 5, period: 1.minute) do |req|
    if req.path.include?('index.php')
      req.remote_ip
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
    Rails.logger.warn "************ Vanilla URL redirect rate limit exceeded!\n************\tIP: #{req.remote_ip}\n************\tpath: #{req.path}\n************\tquery: #{req.params}"
  end
end

# Block suspicious requests
# After 2 blocked requests in 10 minutes, block all requests from that IP for
# 1 hour.
Rack::Attack.blocklist('fail2ban shenanigans') do |req|
  Rack::Attack::Fail2Ban.filter("tomfoolery-#{req.remote_ip}", maxretry: 2, findtime: 10.minutes, bantime: 3.hours) do
    req.path.include?('wp-admin') ||
    req.path.include?('wp-login')
  end
end

# Actually block people who keep going to index.php URLs past the throttling
Rack::Attack.blocklist('fail2ban index.php') do |req|
  Rack::Attack::Allow2Ban.filter("indexers-#{req.remote_ip}", maxretry: 5, findtime: 3.minutes, bantime: 3.hours) do
    req.path.include?('bad_route.html')
  end
end