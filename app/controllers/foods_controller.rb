class FoodsController < ApplicationController
  before_action :set_food, only: %i[show update destroy]
  before_action :authenticate_admin

  def index
    @food = Food.new
    @categories = Category.includes(:foods).all # To Prevent N+1 queries
  end

  def show
    @promotion = Promotion.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      render partial: 'food', locals: { food: @food }, status: :created
    else
      render json: { message: 'Error! Unable to create Food!' }, status: :unprocessable_entity
    end
  end

  def update
    if @food.update(food_params)
      render partial: 'food', locals: { food: @food }, status: :ok
    else
      render json: { message: 'Error! Unable to Update Food' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @food.destroy
      render json: { message: 'Food Deleted Successfully !' }, status: :ok
    else
      render json: { message: 'Error! Unable to Delete Food' }, status: :unprocessable_entity
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :description, :price, :quantity, :category_id, images: [])
  end
end
