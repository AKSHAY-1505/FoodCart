require 'rails_helper'

RSpec.describe OrderDeliveryAgent, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      order_delivery_agent = FactoryBot.build(:order_delivery_agent)
      expect(order_delivery_agent).to be_valid
    end

    it 'is not valid without assigned_at' do
      order_delivery_agent = FactoryBot.build(:order_delivery_agent, assigned_at: nil)
      expect(order_delivery_agent).not_to be_valid
    end
  end
end
