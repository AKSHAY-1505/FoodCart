require 'rails_helper'

RSpec.describe Services::CartItemService::CartItemUpdator do
  describe 'update cart item details' do
    let(:user) { create(:user) }
    let(:food) { create(:food, price: 10, quantity: 100) }
    let(:order_item) { create(:order_item, user: user, food: food, quantity: 5, subtotal: 50) }
    let(:new_quantity) { 3 }

    before do
      # Stub the DiscountCalculator to return a fixed discount for testing purposes
      allow_any_instance_of(Services::CartItemService::DiscountCalculator).to receive(:calculate_discount).and_return(5)
    end

    it 'updates the item quantity and subtotal' do
      Services::CartItemService::CartItemUpdator.new(order_item, new_quantity).update_item_details
      order_item.reload

      expect(order_item.quantity).to eq(new_quantity)
      expect(order_item.subtotal).to eq(food.price * new_quantity)
    end

    it 'updates the item discount' do
      Services::CartItemService::CartItemUpdator.new(order_item, new_quantity).update_item_details
      order_item.reload

      expect(order_item.discount).to eq(5)
    end

    it 'updates the food stock correctly' do
      previous_food_quantity = food.quantity
      previous_item_quantity = order_item.quantity

      Services::CartItemService::CartItemUpdator.new(order_item, new_quantity).update_item_details
      food.reload

      expect(food.quantity).to eq(previous_food_quantity + (previous_item_quantity - new_quantity))
    end
  end
end
