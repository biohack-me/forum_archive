class BadgesController < ApplicationController
  caches_action :show, expires_in: CACHE_TIME

  def show
    @badge = Badge.find(params[:id])
    @page_title = @badge.name
  end

end
