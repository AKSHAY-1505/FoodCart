class OrderMailer < ApplicationMailer
  def new_order(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: 'Order Placed On FoodCart')
  end
end
