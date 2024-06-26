class DeliveryAgentsController < ApplicationController
  before_action :authenticate_admin, only: %i[new create]
  before_action :authenticate_delivery_agent, only: %i[home]

  def create
    @agent = User.new(delivery_agent_params)

    if @agent.save
      redirect_to admin_home_path, notice: 'Delivery Agent Created Successfully!'
    else
      redirect_to new_delivery_agent_path, alert: @agent.errors.full_messages
    end
  end

  def new
    @deliery_agent_role_id = Role.find_by(name: 'Delivery Agent').id
    @delivery_agent = User.new
  end

  def home
    @active_orders = Order.includes(:order_delivery_agent)
                          .where(order_delivery_agent: { user: current_user,
                                                         delivered_at: nil }).order('assigned_at DESC')

    @statuses = Order.statuses
  end

  private

  def delivery_agent_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  end
end
