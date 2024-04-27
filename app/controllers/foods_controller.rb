class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]
  before_action :authenticate_user

  def index
    @food = Food.new
    @categories = Category.all
  end

  def show
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)

    if @food.save 
      render partial: 'food', locals: {food: @food}, status: :created
    else
      render json: {message: "Error! Unable to create Food!"}, status: :unprocessable_entity
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
    remove_food_from_users_carts(@food)

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

    def authenticate_user
      redirect_to root_path, alert: "You are not authorized to visit the page" unless current_user&.admin?
    end

    def remove_food_from_users_carts(food)
      cart_items = CartItem.where(food: food)

      cart_items.each do |item|
        amount = item.quantity * item.food.price
        cart = item.cart
        cart.total -= amount
        cart.save
      end

      cart_items.delete_all
    end
end
