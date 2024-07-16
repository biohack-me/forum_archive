class TagsController < ApplicationController
  caches_action :show, expires_in: CACHE_TIME

  def show
     @results = []
    if params[:tag] && !params[:tag].empty?
      @results = Discussion.tagged(params[:tag]).sorted
    end
  end

end
