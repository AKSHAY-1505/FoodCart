module CartsHelper
  def food_stock(item)
    item.food.quantity + item.quantity
  end

  def display_cart_items(cart_items)
    yield if cart_items.any?
  end

  def display_cart_empty_message(cart_items)
    yield if cart_items.none?
  end
end
