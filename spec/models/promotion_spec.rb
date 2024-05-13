require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'associations' do
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      promotion = FactoryBot.build(:promotion)
      expect(promotion).to be_valid
    end

    it 'is not valid without title' do
      promotion = FactoryBot.build(:promotion, title: nil)
      expect(promotion).not_to be_valid
    end

    it 'is not valid without description' do
      promotion = FactoryBot.build(:promotion, description: nil)
      expect(promotion).not_to be_valid
    end

    it 'is not valid without from_date' do
      promotion = FactoryBot.build(:promotion, from_date: nil)
      expect(promotion).not_to be_valid
    end

    it 'is not valid without to_date' do
      promotion = FactoryBot.build(:promotion, to_date: nil)
      expect(promotion).not_to be_valid
    end

    it 'is not valid without a discount percentage' do
      promotion = FactoryBot.build(:promotion, discount_percentage: nil)
      expect(promotion).not_to be_valid
    end

    it 'is not valid with discount percentage less than 1' do
      promotion = FactoryBot.build(:promotion, discount_percentage: -10)
      expect(promotion).not_to be_valid
    end

    it 'is not valid with discount percentage greater than 100' do
      promotion = FactoryBot.build(:promotion, discount_percentage: 101)
      expect(promotion).not_to be_valid
    end

    it 'is not valid when to_date is before from_date' do
      promotion = FactoryBot.build(:promotion, from_date: '2020-01-01', to_date: '2019-12-01')
      expect(promotion).not_to be_valid
    end
  end
end
