class DiscussionsController < ApplicationController

  def show
    params[:page] ||= '1'
    (params[:page].to_i > 0) or params[:page] = '1'
    @discussion = Discussion.find(params[:id])
    @page_title = @discussion.name
  end
  
end
