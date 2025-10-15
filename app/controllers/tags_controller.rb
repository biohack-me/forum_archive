class TagsController < ApplicationController
  caches_action :show, expires_in: CACHE_TIME, race_condition_ttl: CACHE_TTL

  def show
     @results = []
    if params[:tag] && !params[:tag].empty?
      tag_object = Tag.by_name(params[:tag]).first
      search_tag = tag_object.blank? ? params[:tag] : tag_object.id
      @results = Discussion.tagged(search_tag).sorted
    end
  end

end
