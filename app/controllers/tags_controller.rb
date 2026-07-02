class TagsController < ApplicationController

  def show
    @results = []
    if params[:tag] && !params[:tag].empty?
      tag_string = params[:tag]
      tag_object = Tag.by_name(tag_string).first
      @results = Rails.cache.fetch("tagged_#{tag_string}", expires_in: 12.hours) do
                  tagged_with_string = Discussion.tagged(tag_string).sorted.to_a
                  tagged_with_id     = tag_object ? Discussion.tagged(tag_object.id).sorted.to_a : []
                  tagged_with_string + tagged_with_id
                end
    end
  end

end
