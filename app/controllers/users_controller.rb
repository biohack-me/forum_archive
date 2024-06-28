class UsersController < ApplicationController
  caches_action :show,        expires_in: 12.hours
  caches_action :discussions, expires_in: 12.hours
  caches_action :comments,    expires_in: 12.hours

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
