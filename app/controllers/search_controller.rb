class SearchController < ApplicationController

  def index
    @results = []

    if params[:s] && !params[:s].empty?
      # first search discussions
      @results << Discussion.search(params[:s])

      # then comments
      @results << Comment.search(params[:s])

      @results.flatten!
    end

  end

end
