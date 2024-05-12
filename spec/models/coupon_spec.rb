require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      coupon = FactoryBot.create(:coupon)
      expect(coupon).to be_valid
    end

    it 'is not valid without code' do
      coupon = FactoryBot.build(:coupon, code: nil)
      expect(coupon).not_to be_valid
    end

    it 'is not valid without discount' do
      coupon = FactoryBot.build(:coupon, discount: nil)
      expect(coupon).not_to be_valid
    end

    it 'is not valid without min_amount' do
      coupon = FactoryBot.build(:coupon, min_amount: nil)
      expect(coupon).not_to be_valid
    end

    it 'is not valid without from_date' do
      coupon = FactoryBot.build(:coupon, from_date: nil)
      expect(coupon).not_to be_valid
    end

    it 'is not valid without to_date' do
      coupon = FactoryBot.build(:coupon, to_date: nil)
      expect(coupon).not_to be_valid
    end

    it 'is not valid without a valid discount' do
      coupon = FactoryBot.build(:coupon, discount: -10)
      expect(coupon).not_to be_valid
    end

    it 'is not valid without a valid min_amount' do
      coupon = FactoryBot.build(:coupon, min_amount: -100)
      expect(coupon).not_to be_valid
    end

    it 'is not valid with a to_date less than from_date' do
      coupon = FactoryBot.build(:coupon, from_date: '2020-01-01', to_date: '2019-12-01')
      expect(coupon).not_to be_valid
    end

    it 'is not valid with a duplicate code' do
      coupon = FactoryBot.create(:coupon)
      duplicate_coupon = FactoryBot.build(:coupon, code: coupon.code)
      expect(duplicate_coupon).not_to be_valid
    end
  end
end
