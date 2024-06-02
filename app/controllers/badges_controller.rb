class BadgesController < ApplicationController
  caches_action :show, expires_in: 12.hours

  def show
    @badge = Badge.find(params[:id])
    @page_title = @badge.name
  end

end
