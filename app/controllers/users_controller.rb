class UsersController < ApplicationController

  def show
    @user = Rails.cache.fetch("user_#{params[:id]}", expires_in: 12.hours) do
              User.profile_metadata.find(params[:id])
            end
    @page_title = @user.name
  end

  def discussions
    @user_d = Rails.cache.fetch("user_discussions_#{params[:user_id]}", expires_in: 12.hours) do
                User.with_discussions.find(params[:user_id])
              end
    render 'users/_user_discussions', layout: false
  end

  def comments
    @user_c = Rails.cache.fetch("user_comments_#{params[:user_id]}", expires_in: 12.hours) do
                User.with_comments.find(params[:user_id])
              end
    render 'users/_user_comments', layout: false
  end

end
