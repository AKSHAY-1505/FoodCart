module Services
  module Cart
    class PromotionHelper
      def initialize(cart_items)
        @cart_items = cart_items
      end

      def call
        promotions = []
        discount = 0
        @cart_items.each do |item|
          # Find the promotion with the highest discount percentage where the current date is within the promotion's date range
          best_promotion = item.food.promotions.where('? BETWEEN from_date AND to_date', Date.current).order(discount_percentage: :desc).first # rubocop:disable Layout/LineLength

          next unless best_promotion

          discount += ((best_promotion.discount_percentage.to_f / 100) * item.food.price) * item.quantity
          promotions << best_promotion
        end

        { promotions: promotions, discount: discount }
      end
    end
  end
end
