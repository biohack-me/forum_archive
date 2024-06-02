class UsersController < ApplicationController
  caches_action :show, expires_in: 12.hours

  def show
    @user = User.find(params[:id])
    @page_title = @user.name
  end

end
