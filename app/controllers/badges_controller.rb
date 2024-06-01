class BadgesController < ApplicationController

  def show
    @badge = Badge.find(params[:id])
    @page_title = @badge.name
  end

end
