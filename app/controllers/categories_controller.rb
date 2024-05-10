class CategoriesController < ApplicationController
  before_action :authenticate_admin
  def create
    category = Category.new(category_params)

    if category.save
      render json: { category: category }, status: :created
    else
      render json: { message: 'Unable to Create Category' }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.permit(:name)
  end
end
