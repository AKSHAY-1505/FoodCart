require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:order_delivery_agents).dependent(:destroy) }
  end
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it 'is not valid without name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with name more than 50 characters' do
      user = FactoryBot.build(:user, name: 'testtesttesttesttesttesttesttesttesttesttesttesttest')
      expect(user).not_to be_valid
    end

    it 'is not valid without email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a valid email' do
      user = FactoryBot.build(:user, email: 'abcd')
      expect(user).not_to be_valid
    end

    it 'is not valid without password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without matching password and password confirmation' do
      user = FactoryBot.build(:user, password_confirmation: 'Not the same as password')
      expect(user).to_not be_valid
    end

    it 'is valid with matching password and password confirmation' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a role' do
      user = FactoryBot.build(:user, role: nil)
      expect(user).not_to be_valid
    end
  end
end
