class OrdersController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  before_action :set_order, only: %i[update assign_agent]

  def index
    @orders = Order.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def new
    @address = Address.new
    @addresses = Address.where(customer: current_customer)
  end

  def create
    cart = current_customer.cart
    order = Order.new(customer: current_customer, subtotal: cart.subtotal, delivery_charge: cart.delivery_charge,
                      discount: cart.discount, total: cart.total, address_id: params[:address_id].to_i)
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
    redirect_to root_path, alert: 'You are not authorized to access this page!' unless current_user&.admin?
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
