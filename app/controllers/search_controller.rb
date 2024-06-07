class SearchController < ApplicationController

  def index
    @users = []
    @results = []

    if params[:s] && !params[:s].empty?
      # search users
      @users = User.find_by_username(params[:s])

      # search discussions and comments
      @results << Discussion.search(params[:s])
      @results << Comment.search(params[:s])
      @results.flatten!
    end

  end

end
