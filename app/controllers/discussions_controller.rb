class DiscussionsController < ApplicationController

  def show
    params[:page] ||= '1'
    (params[:page].to_i > 0) or params[:page] = '1'
    @discussion = Rails.cache.fetch("discussion_#{params[:id]}", expires_in: 12.hours) do
                    Discussion.find(params[:id])
                  end
    @page_title = @discussion.name
  end
  
end
