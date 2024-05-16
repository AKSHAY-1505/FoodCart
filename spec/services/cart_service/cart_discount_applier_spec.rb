require 'rails_helper'

RSpec.describe Services::CartService::CartDiscountApplier do
  describe '#apply_discount' do
    let(:user) { create(:user) }
    let(:food1) { create(:food, price: 100) }
    let(:food2) { create(:food, price: 150) }
    let(:order_item1) { create(:order_item, user: user, food: food1, quantity: 2) }
    let(:order_item2) { create(:order_item, user: user, food: food2, quantity: 1) }
    let(:cart_items) { [order_item1, order_item2] }
    let(:applier) { Services::CartService::CartDiscountApplier.new(cart_items) }

    before do
      allow_any_instance_of(Services::CartItemService::DiscountCalculator).to receive(:calculate_discount).and_return(30)
    end

    it 'applies discount to each cart item' do
      expect(order_item1.discount).to eq(0)
      expect(order_item2.discount).to eq(0)

      Services::CartService::CartDiscountApplier.new(cart_items).apply_discount

      expect(order_item1.reload.discount).to eq(30)
      expect(order_item2.reload.discount).to eq(30)
    end
  end
end
