module Services
  module CartItemService
    # This class is responsible for calculating the discount for a cart item.
    class DiscountCalculator
      def initialize(item)
        @item = item
      end

      def calculate_discount
        best_promotion = @item.food.promotions.where('? BETWEEN from_date AND to_date', Date.current).order(discount_percentage: :desc).first # rubocop:disable Layout/LineLength
        return 0 unless best_promotion

        ((best_promotion.discount_percentage.to_f / 100) * @item.food.price) * @item.quantity
      end
    end
  end
end


