require 'rails_helper'
RSpec.describe Services::CartItemService::CartItemCreator do
  describe 'create a cart item' do
    let(:user) { create(:user) }
    let(:food) { create(:food, id: 1, price: 10, quantity: 100) }
    let(:quantity) { 5 }

    context 'when there is no existing order item' do
      it 'creates a new order item with the correct attributes' do
        expect do
          order_item = Services::CartItemService::CartItemCreator.new(user, food.id, quantity).create_cart_item
          expect(order_item.user).to eq(user)
          expect(order_item.food).to eq(food)
          expect(order_item.quantity).to eq(quantity)
          expect(order_item.subtotal).to eq(food.price * quantity)
          order_item.save
        end.to change { OrderItem.count }.by(1)
      end
    end

    context 'when there is an existing order item' do
      let(:existing_order_item) { create(:order_item, user: user, food: food, quantity: 2, ordered: false) }

      it 'updates the quantity and subtotal of the existing order item' do
        existing_order_item
        expect do
          order_item = Services::CartItemService::CartItemCreator.new(user, food.id, quantity).create_cart_item
          expect(order_item.quantity).to eq(existing_order_item.quantity + quantity)
          expect(order_item.subtotal).to eq(food.price * order_item.quantity)
          order_item.save
        end.to change { OrderItem.count }.by(0)
      end
    end

    it 'decreases the food stock by the ordered quantity' do
      expect do
        Services::CartItemService::CartItemCreator.new(user, food.id, quantity).create_cart_item
        food.reload
      end.to change { food.quantity }.by(-quantity)
    end
  end
end
