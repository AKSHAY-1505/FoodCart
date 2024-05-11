require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'creating a role' do
    it 'is valid with valid attributes' do
      role = FactoryBot.create(:role)
      expect(role).to be_valid
    end

    it 'is not valid without name' do
      role = FactoryBot.build(:role, name: nil)
      expect(role).not_to be_valid
    end

    it 'is not valid with a duplicate name' do
      role1 = FactoryBot.create(:role)
      role2 = FactoryBot.build(:role, name: role1.name)
      expect(role2).not_to be_valid
    end
  end
end
