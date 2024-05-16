# spec/services/cart_item_service/discount_calculator_spec.rb
require 'rails_helper'

RSpec.describe Services::CartItemService::DiscountCalculator do
  describe 'calculate discount' do
    let(:user) { create(:user) }
    let(:food) { create(:food, price: 10) }
    let(:order_item) { create(:order_item, user: user, food: food, quantity: 2) }
    let(:calculator) { Services::CartItemService::DiscountCalculator.new(order_item) }

    context 'when there are multiple active promotions' do
      before do
        create(:promotion, food: food, from_date: Date.current - 1.day, to_date: Date.current + 1.day,
                           discount_percentage: 20)
        create(:promotion, food: food, from_date: Date.current - 2.days, to_date: Date.current + 2.days,
                           discount_percentage: 30)
      end

      it 'calculates the discount based on the best promotion available' do
        expect(Services::CartItemService::DiscountCalculator.new(order_item).calculate_discount).to eq((0.3 * food.price) * order_item.quantity) # 30% discount
      end
    end

    context 'when there are no active promotions' do
      before do
        create(:promotion, food: food, from_date: Date.current - 3.days, to_date: Date.current - 1.day,
                           discount_percentage: 20)
      end
      it 'returns 0' do
        expect(Services::CartItemService::DiscountCalculator.new(order_item).calculate_discount).to eq(0)
      end
    end
  end
end
