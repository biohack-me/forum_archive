class DiscussionsController < ApplicationController
  caches_action :show, expires_in: CACHE_TIME, cache_path: Proc.new { |c| "#{c.params[:id]}_#{c.params[:page]}" }

  def show
    @discussion = Discussion.find(params[:id])
    @page_title = @discussion.name
  end
  
end
