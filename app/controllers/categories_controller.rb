class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.create(category_params)

    redirect_to category_path(@category)
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end
end
