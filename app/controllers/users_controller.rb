class UsersController < ApplicationController
  caches_action :show, expires_in: 12.hours

  def show
    @user = User.profile_metadata.find(params[:id])
    @page_title = @user.name
  end

end
