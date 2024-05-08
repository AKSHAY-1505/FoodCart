module Services
  module CustomerService
    class FoodSuggestion
      def initialize(customer)
        @customer = customer
      end

      def call
        top_five_most_ordered_foods.map { |food_name| Food.find_by(name: food_name) }.compact
      end

      def top_five_most_ordered_foods
        @customer.orders.joins(:order_items)
                 .group('order_items.food_name')
                 .order('SUM(order_items.quantity) DESC')
                 .limit(5)
                 .pluck('order_items.food_name')
      end
    end
  end
end
