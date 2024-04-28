class OrdersController < ApplicationController
  def create
    cart = current_customer.cart
    delivery_charge = cart.total > 500 ? 0 : 30

    # Subtract discount here
    total = cart.total + delivery_charge

    # Update discount here
    order = Order.new(customer: current_customer, subtotal: cart.total, delivery_charge:,
                      discount: 0, total:)

    if order.save
      create_order_items(cart, order)
      redirect_to root_path, notice: 'Order Placed !'
    else
      redirect_to cart_path(current_customer.cart), alert: 'Error! Unable to place Order !'
    end
  end

  private

  def create_order_items(cart, order)
    cart_items = CartItem.where(cart:)

    cart_items.each do |item|
      OrderItem.create(order:, food_name: item.food.name, food_price: item.food.price,
                       quantity: item.quantity)
    end

    cart_items.destroy_all
  end
end
