require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:foods) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      category = FactoryBot.create(:category)
      expect(category).to be_valid
    end

    it 'is not valid without name' do
      category = FactoryBot.build(:category, name: nil)
      expect(category).not_to be_valid
    end
  end
end
