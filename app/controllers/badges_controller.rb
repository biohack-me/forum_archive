class BadgesController < ApplicationController

  def show
    @badge =  Rails.cache.fetch("badge_#{params[:id]}", expires_in: 12.hours) do
                Badge.find(params[:id])
              end
    @page_title = @badge.name
  end

end
