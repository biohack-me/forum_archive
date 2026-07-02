class CategoriesController < ApplicationController

  def index
    @categories = Rails.cache.fetch("all_categories", expires_in: 12.hours) do
                    Category.top_level.sorted.to_a
                  end
  end

  def show
    @category = Rails.cache.fetch("category_#{params[:id]}", expires_in: 12.hours) do
                  Category.find(params[:id])
                end
    @page_title = @category.name
  end

end
