require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:food) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      order_item = FactoryBot.build(:order_item)
      expect(order_item).to be_valid
    end

    it 'is not valid without quantity' do
      order_item = FactoryBot.build(:order_item, quantity: nil)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without ordered' do
      order_item = FactoryBot.build(:order_item, ordered: nil)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without subtotal' do
      order_item = FactoryBot.build(:order_item, subtotal: nil)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without discount' do
      order_item = FactoryBot.build(:order_item, discount: nil)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without valid quantity' do
      order_item = FactoryBot.build(:order_item, quantity: -100)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without valid subtotal' do
      order_item = FactoryBot.build(:order_item, subtotal: -100)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without valid discount' do
      order_item = FactoryBot.build(:order_item, discount: -100)
      expect(order_item).not_to be_valid
    end
  end
end
