require 'rails_helper'

RSpec.describe Services::CustomerService::FoodSuggestion do
  describe '#suggested_foods' do
    let(:user) { create(:user) }
    let(:food1) { create(:food) }
    let(:food2) { create(:food) }
    let(:food3) { create(:food) }
    let(:order1) { create(:order, user: user) }
    let(:order2) { create(:order, user: user) }
    let(:order3) { create(:order, user: user) }

    before do
      # Creating order items for food1
      create(:order_item, order: order1, food: food1, quantity: 5)
      create(:order_item, order: order2, food: food1, quantity: 3)
      # Creating order items for food2
      create(:order_item, order: order2, food: food2, quantity: 2)
      create(:order_item, order: order3, food: food2, quantity: 4)
      # food3 is not ordered
    end

    it 'returns the top 5 most ordered foods' do
      suggestion = described_class.new(user)
      suggested_foods = suggestion.suggested_foods

      expect(suggested_foods.length).to eq(2) # 3 foods created, but only 2 were ordered
      expect(suggested_foods).to include(food1, food2)
      expect(suggested_foods).not_to include(food3)
    end
  end
end
