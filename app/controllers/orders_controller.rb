class OrdersController < ApplicationController
  before_action :authenticate_user
  def create
    cart = current_customer.cart
    delivery_charge = cart.total > 500 ? 0 : 30

    # Subtract discount here
    total = cart.total + delivery_charge

    # Update discount here
    order = Order.new(customer: current_customer, subtotal: cart.total, delivery_charge:,
                      discount: 0, total:, delivery_agent: nil)
    if order.save
      create_order_items(cart, order)
      redirect_to root_path, notice: 'Order Placed !'
    else
      redirect_to cart_path(current_customer.cart), alert: 'Error! Unable to place Order !'
    end
  end

  def assign_agent
    order = Order.find(params[:id])
    agent = DeliveryAgent.find(params[:delivery_agent])

    order.delivery_agent = agent
    order.status = 'delivery_agent_assigned'
    if order.save
      render json: { orderId: order.id, agentName: agent.user.name }, status: :ok
    else
      render json: { message: 'Unable to Assign Agent!' }, status: :unprocessable_entity
    end
  end

  def update
    order = Order.find(params[:id])
    order.status = params[:status].to_i
    if order.save
      update_active_status(order)
      render json: { order_id: order.id, status: order.status.titleize, active: order.is_active }, status: :ok
    else
      render json: { message: 'Unable to update status' }, status: :unprocessable_entity
    end
  end

  def index
    @orders = Order.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  private

  def create_order_items(cart, order)
    cart_items = CartItem.where(cart: cart)
    cart_items.each do |item|
      OrderItem.create(order: order, food_name: item.food.name, food_price: item.food.price,
                       quantity: item.quantity)
    end
    cart_items.destroy_all
  end

  def update_active_status(order)
    return unless order.status == 'delivered'

    order.is_active = false
    order.save
  end

  def authenticate_user
    redirect_to root_path, alert: 'You are not authorized to access this page!' unless current_user&.admin?
  end
end
