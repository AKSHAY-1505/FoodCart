require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:order_items) }
    it { should have_many(:promotions).dependent(:destroy) }
    it { should have_many_attached(:images) }
  end
  
  describe 'validations' do
    it 'is valid with valid attributes' do
      food = FactoryBot.create(:food)
      expect(food).to be_valid
    end

    it 'is not valid without name' do
      food = FactoryBot.build(:food, name: nil)
      expect(food).not_to be_valid
    end

    it 'is not valid without price' do
      food = FactoryBot.build(:food, price: nil)
      expect(food).not_to be_valid
    end

    it 'is not valid without quantity' do
      food = FactoryBot.build(:food, quantity: nil)
      expect(food).not_to be_valid
    end

    it 'is not valid without description' do
      food = FactoryBot.build(:food, description: nil)
      expect(food).not_to be_valid
    end

    it 'is not valid without a category' do
      food = FactoryBot.build(:food, category: nil)
      expect(food).not_to be_valid
    end

    it 'is not valid without a valid price' do
      food = FactoryBot.build(:food, price: -100)
      expect(food).not_to be_valid
    end

    it 'is not valid without a valid quantity' do
      food = FactoryBot.build(:food, quantity: -10)
      expect(food).not_to be_valid
    end

    it 'is not valid without images' do
      food = FactoryBot.build(:food)
      food.images.purge
      expect(food).not_to be_valid
    end
  end
end
