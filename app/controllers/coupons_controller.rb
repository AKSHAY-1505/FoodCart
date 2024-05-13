class CouponsController < ApplicationController
  before_action :authenticate_admin, only: %i[index create]
  before_action :set_coupon, only: %i[destroy update]

  def index
    @coupon =  Coupon.new
    @coupons = Coupon.all
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
    if @coupon.destroy
      render json: { message: 'Coupon Deleted Successfully' }, status: :ok
    else
      render json: { message: 'Unable to Delete Coupon' }, status: :unprocessable_entity
    end
  end

  def update
    if @coupon.update(coupon_params)
      render partial: 'coupons/coupon', locals: { coupon: @coupon }, status: :ok
    else
      render json: { message: 'Unable to Create Coupon' }, status: :unprocessable_entity
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount, :min_amount, :from_date, :to_date)
  end

  def set_coupon
    @coupon = Coupon.find_by(id: params[:id])
  end
end
