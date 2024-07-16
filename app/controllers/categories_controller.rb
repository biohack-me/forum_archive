class CategoriesController < ApplicationController
  caches_action :index, :show, expires_in: CACHE_TIME

  def index
    @categories = Category.top_level.sorted
  end

  def show
    @category = Category.find(params[:id])
    @page_title = @category.name
  end

end
