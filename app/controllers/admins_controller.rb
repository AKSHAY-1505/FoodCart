class AdminsController < ApplicationController
  before_action :authenticate_user

  def home
    @active_orders = Order.where(is_active: true).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    @agents = DeliveryAgent.all
  end

  private

  def authenticate_user
    redirect_to root_path, alert: 'You are not authorised to access this page!' unless current_user&.admin?
  end
end
