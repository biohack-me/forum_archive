class UsersController < ApplicationController
  caches_action :show,        expires_in: CACHE_TIME, race_condition_ttl: CACHE_TTL
  caches_action :discussions, expires_in: CACHE_TIME, race_condition_ttl: CACHE_TTL
  caches_action :comments,    expires_in: CACHE_TIME, race_condition_ttl: CACHE_TTL

  def show
    @user = User.profile_metadata.find(params[:id])
    @page_title = @user.name
  end

  def discussions
    @user = User.with_discussions.find(params[:user_id])
    render 'users/_user_discussions', layout: false
  end

  def comments
    @user = User.with_comments.find(params[:user_id])
    render 'users/_user_comments', layout: false
  end

end
