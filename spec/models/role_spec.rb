require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { should have_many(:users) }
  end
  
  describe 'validations' do
    it 'is valid with valid attributes' do
      role = FactoryBot.create(:role)
      expect(role).to be_valid
    end

    it 'is not valid without name' do
      role = FactoryBot.build(:role, name: nil)
      expect(role).not_to be_valid
    end
  end
end
