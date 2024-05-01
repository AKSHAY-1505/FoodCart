module Services
  module Cart
    class DiscountCalculator
      def initialize(cart_items)
        @cart_items = cart_items
      end

      def call
        item_discounts = {}
        @cart_items.each do |item|
          # Find the promotion with the highest discount percentage where the current date is within the promotion's date range
          best_promotion = item.food.promotions.where('? BETWEEN from_date AND to_date', Date.current).order(discount_percentage: :desc).first # rubocop:disable Layout/LineLength

          if best_promotion
            discount = ((best_promotion.discount_percentage.to_f / 100) * item.food.price) * item.quantity
            item_discounts[item.id] = discount
          end
        end
        item_discounts
      end
    end
  end
end
