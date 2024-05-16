module Services
  module CustomerService
    class FoodSuggestion
      def initialize(customer)
        @customer = customer
      end

      def suggested_foods
        top_five_food_ids = top_five_most_ordered_foods
        Food.where(id: top_five_food_ids)
      end

      def top_five_most_ordered_foods
        @customer.orders
                 .joins(:order_items)
                 .group('order_items.food_id')
                 .select('order_items.food_id, SUM(order_items.quantity)')
                 .order('SUM(order_items.quantity) DESC')
                 .limit(5)
                 .pluck(:food_id)
      end
    end
  end
end
