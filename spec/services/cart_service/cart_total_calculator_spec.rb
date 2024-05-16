require 'rails_helper'

RSpec.describe Services::CartService::CartTotalCalculator do
  describe 'calculate total' do
    let(:user) { create(:user) }
    let(:food1) { create(:food, price: 10) }
    let(:food2) { create(:food, price: 20) }
    let!(:order_item1) { create(:order_item, user: user, food: food1, quantity: 2, subtotal: 20, ordered: false) }
    let!(:order_item2) { create(:order_item, user: user, food: food2, quantity: 3, subtotal: 60, ordered: false) }

    context 'when there is no coupon' do
      it 'calculates the total correctly' do
        expect(Services::CartService::CartTotalCalculator.new(user).calculate_total).to eq({
          subtotal: 80,
          delivery_charge: 30,
          coupon_discount: 0,
          discount: 0,
          total: 110
        })
      end
    end

    context 'when there is a valid coupon' do
      let!(:coupon) { create(:coupon, code: 'TEST', min_amount: 50, discount: 10, from_date: Date.current - 5.days, to_date: Date.current + 5.days) }

      it 'calculates the total with coupon discount applied' do
        expect(Services::CartService::CartTotalCalculator.new(user, coupon.code).calculate_total).to eq({
          subtotal: 80,
          delivery_charge: 30,
          coupon_discount: 10,
          discount: 10,
          total: 100
        })
      end
    end

    context 'when the subtotal is greater than the minimum amount for free delivery' do
      let!(:order_item1) { create(:order_item, user: user, food: food1, quantity: 50, subtotal: 500, ordered: false) }

      it 'applies free delivery' do
        expect(Services::CartService::CartTotalCalculator.new(user).calculate_total[:delivery_charge]).to eq(0)
      end
    end
  end
end
