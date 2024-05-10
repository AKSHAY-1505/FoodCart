class PromotionsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_promotion, only: %i[update destroy]

  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      render partial: 'promotions/promotion', locals: { promotion: @promotion, food: @promotion.food }, status: :ok
    else
      render json: { message: 'Unable to create promotion' }, status: :unprocessable_entity
    end
  end

  def update
    if @promotion.update(promotion_params)
      render partial: 'promotions/promotion', locals: { promotion: @promotion, food: @promotion.food }, status: :ok
    else
      render json: { message: 'Unable to update promotion' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @promotion.destroy
      render json: { promotionId: @promotion.id }, status: :ok
    else
      render json: { message: 'Unable to delete promotion' }, status: :unprocessable_entity
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:title, :description, :from_date, :to_date, :discount_percentage, :food_id)
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
