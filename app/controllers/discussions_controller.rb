class DiscussionsController < ApplicationController

  def show
    @discussion = Discussion.find(params[:id])
    @page_title = @discussion.name
  end
  
end
