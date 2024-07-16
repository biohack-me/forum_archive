class BadgesController < ApplicationController
  caches_action :show, expires_in: CACHE_TIME, race_condition_ttl: CACHE_TTL

  def show
    @badge = Badge.find(params[:id])
    @page_title = @badge.name
  end

end
