class DeliveryAgentsController < ApplicationController
  before_action :authenticate_admin, only: %i[new create]
  before_action :authenticate_user, only: %i[home]

  def create
    @agent = User.new(delivery_agent_params)
    if @agent.save
      redirect_to admin_home_path, notice: 'Delivery Agent Created Successfully!'
    else
      redirect_to admin_home_path, alert: 'Error! Unable to Create Delivery Agent'
    end
  end

  def new
    @agent = User.new
  end

  def home
    @active_orders = current_user.orders.where(is_active: true)
    @statuses = Order.statuses
  end

  private

  def delivery_agent_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  end

  def authenticate_user
    redirect_to root_path alert: 'You are not authorized to visit that page!' unless user_is_delivery_agent?
  end

  def authenticate_admin
    redirect_to root_path alert: 'You are not authorized to visit that page!' unless user_is_admin?
  end
end
