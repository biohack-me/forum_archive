class TagsController < ApplicationController

  def show
     @results = []

    if params[:tag] && !params[:tag].empty?
      @results = Discussion.tagged(params[:tag]).sorted
    end
  end

end
