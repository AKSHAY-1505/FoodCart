class AdminsController < ApplicationController
  before_action :authenticate_admin

  def home
    @active_orders = Order.where(is_active: true).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    @agents = User.where(role_id: 2)
  end
end
