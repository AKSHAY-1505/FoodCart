module Services
  module CustomerService
    class FoodSuggestion
      def initialize(customer)
        @customer = customer
      end

      def call
        top_five_most_ordered_foods.map { |food_id| Food.find_by(id: food_id) }.compact
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
