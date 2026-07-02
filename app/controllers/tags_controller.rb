class TagsController < ApplicationController

  def show
    @results = []
    if params[:tag] && !params[:tag].empty?
      tag_object = Tag.by_name(params[:tag]).first
      search_tag = tag_object.blank? ? params[:tag] : tag_object.id
      @results = Rails.cache.fetch("tagged_#{search_tag}", expires_in: 12.hours) do
                  Discussion.tagged(search_tag).sorted.to_a
                end
    end
  end

end
