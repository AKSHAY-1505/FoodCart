require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:foods).through(:order_items) }
    it { should belong_to(:address) }
    it { should have_one(:order_delivery_agent) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      order = FactoryBot.build(:order)
      expect(order).to be_valid
    end

    it 'is not valid without subtotal' do
      order = FactoryBot.build(:order, subtotal: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without delivery_charge' do
      order = FactoryBot.build(:order, delivery_charge: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without discount' do
      order = FactoryBot.build(:order, discount: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without total' do
      order = FactoryBot.build(:order, total: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without status' do
      order = FactoryBot.build(:order, status: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without valid subtotal' do
      order = FactoryBot.build(:order, subtotal: -100)
      expect(order).not_to be_valid
    end

    it 'is not valid without valid delivery_charge' do
      order = FactoryBot.build(:order, delivery_charge: -100)
      expect(order).not_to be_valid
    end

    it 'is not valid without valid discount' do
      order = FactoryBot.build(:order, discount: -100)
      expect(order).not_to be_valid
    end
  end

  describe 'methods' do
    it 'assigns an agent' do
      order = FactoryBot.build(:order)
      agent = FactoryBot.build(:user)
      order.assign_agent(agent)
      expect(order.status).to eq('delivery_agent_assigned')
    end

    it 'updates status' do
      order = FactoryBot.build(:order)
      order.update_status('out_for_delivery')
      expect(order.status).to eq('out_for_delivery')
    end

    it 'becomes inactive after order is delivered' do
      order = FactoryBot.build(:order)
      FactoryBot.build(:order_delivery_agent, order: order)
      order.update_status('delivered')
      expect(order.is_active).to be_falsy
    end
  end
end
