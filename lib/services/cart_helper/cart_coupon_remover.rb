module Services
  module CartHelper
    class CartCouponRemover
      def initialize(cart)
        @cart = cart
      end

      def call
        @cart.coupon = nil
        @cart.save
        Services::CartHelper::CartTotalCalculator.new(@cart).call
      end
    end
  end
end
