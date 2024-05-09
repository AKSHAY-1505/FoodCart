class OrdersController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  before_action :set_order, only: %i[update assign_agent]
  before_action :collect_cart_details, only: %i[new create]

  def index
    @orders = Order.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def new
    @address = Address.new
    @addresses = Address.where(user: current_user)
  end

  def create
    order = Order.new(user: current_user, subtotal: @cart_details[:subtotal], delivery_charge: @cart_details[:delivery_charge],
                      discount: @cart_details[:discount], total: @cart_details[:total], address_id: params[:address_id].to_i)
    if order.save
      redirect_to root_path, notice: 'Order Placed !'
    else
      redirect_to cart_path(current_customer.cart), alert: 'Error! Unable to place Order !'
    end
  end

  def assign_agent
    agent = DeliveryAgent.find(params[:delivery_agent])

    if @order.assign_agent(agent)
      render json: { orderId: @order.id, agentName: agent.user.name }, status: :ok
    else
      render json: { message: 'Unable to Assign Agent!' }, status: :unprocessable_entity
    end
  end

  def update
    if @order.update_status(params[:status])
      render json: { order_id: @order.id, status: @order.status.titleize, active: @order.is_active }, status: :ok
    else
      render json: { message: 'Unable to update status' }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_admin
    redirect_to root_path, alert: 'You are not authorized to access this page!' unless user_is_admin?
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def collect_cart_details
    @cart_details = Services::CartHelper::CartTotalCalculator.new(current_user, params[:coupon]).call
  end
end
