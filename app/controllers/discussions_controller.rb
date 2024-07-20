class DiscussionsController < ApplicationController
  caches_action :show, expires_in: CACHE_TIME, race_condition_ttl: CACHE_TTL, cache_path: Proc.new { |c| "#{c.params[:id]}_#{c.params[:page].to_i}" }

  def show
    params[:page] ||= '1'
    (params[:page].to_i > 0) or params[:page] = '1'
    @discussion = Discussion.find(params[:id])
    @page_title = @discussion.name
  end
  
end
