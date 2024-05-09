class CouponsController < ApplicationController
  before_action :authenticate_admin, only: %i[index new create]

  def index
    @coupon =  Coupon.new
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
  end

  def create
    coupon = Coupon.new(coupon_params)
    if coupon.save
      render partial: 'coupons/coupon', locals: { coupon: coupon }, status: :created
    else
      render json: { message: 'Unable to Create Coupon' }, status: :unprocessable_entity
    end
  end

  def destroy
    coupon = Coupon.find(params[:id])
    if coupon.destroy
      render json: { message: 'Coupon Deleted Successfully' }, status: :ok
    else
      render json: { message: 'Unable to Delete Coupon' }, status: :unprocessable_entity
    end
  end

  def update
    coupon = Coupon.find(params[:id])
    if coupon.update(coupon_params)
      render partial: 'coupons/coupon', locals: { coupon: coupon }, status: :ok
    else
      render json: { message: 'Unable to Create Coupon' }, status: :unprocessable_entity
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount, :min_amount, :from_date, :to_date)
  end

  def authenticate_admin
    return false unless user_is_admin?

    true
  end
end
