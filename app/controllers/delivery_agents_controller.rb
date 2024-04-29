class DeliveryAgentsController < ApplicationController
  before_action :authenticate_user
  def create
    @agent = DeliveryAgent.new(delivery_agent_params)
    @agent.user.role = 2
    if @agent.save
      redirect_to admin_home_path, notice: 'Delivery Agent Created Successfully!'
    else
      redirect_to admin_home_path, alert: 'Error! Unable to Create Delivery Agent'
    end
  end

  def new
    @agent = DeliveryAgent.new
    @agent.build_user
  end

  def home
    @active_orders = current_user.delivery_agent.orders.where(is_active: true)
    @statuses = Order.statuses
  end

  private

  def delivery_agent_params
    params.require(:delivery_agent).permit(user_attributes: %i[name email password password_confirmation role])
  end

  def authenticate_user
    redirect_to root_path alert: 'You are ot authorized to visit that page!' unless current_user&.delivery_agent?
  end
end
