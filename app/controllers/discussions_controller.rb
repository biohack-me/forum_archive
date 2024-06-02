class DiscussionsController < ApplicationController
  caches_action :show, expires_in: 12.hours

  def show
    @discussion = Discussion.find(params[:id])
    @page_title = @discussion.name
  end
  
end
