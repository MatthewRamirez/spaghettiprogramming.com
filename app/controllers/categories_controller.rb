class CategoriesController < ApplicationController
  include ApplicationHelper

  before_filter :redirect_to_root_unless_signed_in, :except => [ :show ]

  def index
    @title = "Categories"
    @categories = Category.all
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    category = Category.new(category_params)
    category.save ? redirect_to(categories_path) : render(:new)
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      redirect_to categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
