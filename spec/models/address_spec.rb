require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'creating a address' do
    it 'is valid with valid attributes' do
      address = FactoryBot.create(:address)
      expect(address).to be_valid
    end

    it 'is not valid without house_number' do
      address = FactoryBot.build(:address, house_number: nil)
      expect(address).not_to be_valid
    end

    it 'is not valid without street_name' do
      address = FactoryBot.build(:address, street_name: nil)
      expect(address).not_to be_valid
    end

    it 'is not valid without locality' do
      address = FactoryBot.build(:address, locality: nil)
      expect(address).not_to be_valid
    end

    it 'is not valid without city' do
      address = FactoryBot.build(:address, city: nil)
      expect(address).not_to be_valid
    end

    it 'is not valid without phone_number' do
      address = FactoryBot.build(:address, phone_number: nil)
      expect(address).not_to be_valid
    end

    it 'is not valid without a valid phone_number' do
      address = FactoryBot.build(:address, phone_number: '12345')
      expect(address).not_to be_valid
    end
  end
end
