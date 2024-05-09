class AdminsController < ApplicationController
  before_action :authenticate_user

  def home
    @active_orders = Order.where(is_active: true).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    @agents = User.where(role_id: 2)
  end

  private

  def authenticate_user
    redirect_to root_path, alert: 'You are not authorised to access this page!' unless user_is_admin?
  end
end
