require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'creating a coupon' do
    it 'is valid with valid attributes' do
      coupon = FactoryBot.create(:coupon)
      expect(coupon).to be_valid
    end
  end
end
