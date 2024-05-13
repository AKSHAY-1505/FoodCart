require 'rails_helper'

RSpec.describe 'Promotions', type: :request do
  let(:admin) { create(:user, role: create(:role, name: 'Admin')) }
  let(:promotion) { create(:promotion) }
  let(:food) { create(:food) }
  let(:valid_attributes) do
    { promotion: { title: 'New Title', description: 'New Description', from_date: Date.today,
                   to_date: Date.today + 30.days, discount_percentage: 25, food_id: food.id } }
  end

  before do
    sign_in admin
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new promotion' do
        expect do
          post promotions_path, params: valid_attributes
        end.to change(Promotion, :count).by(1)
      end

      it 'returns a success response' do
        post promotions_path, params: valid_attributes
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { promotion: { title: '', description: '', from_date: '', to_date: '', discount_percentage: '', food_id: '' } }
      end

      it 'does not create a new promotion' do
        expect do
          post promotions_path, params: invalid_attributes
        end.to change(Promotion, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post promotions_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested promotion' do
        patch promotion_path(promotion), params: valid_attributes
        promotion.reload
        expect(promotion.title).to eq('New Title')
      end

      it 'returns a success response' do
        patch promotion_path(promotion), params: valid_attributes
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { promotion: { title: '', description: '', from_date: '', to_date: '', discount_percentage: '', food_id: '' } }
      end

      it 'does not update the promotion' do
        patch promotion_path(promotion), params: invalid_attributes
        promotion.reload
        expect(promotion.title).not_to eq('New Title')
      end

      it 'returns an unprocessable entity response' do
        patch promotion_path(promotion), params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      promotion
    end
    it 'destroys the requested promotion' do
      expect do
        delete promotion_path(promotion)
      end.to change(Promotion, :count).by(-1)
    end

    it 'returns a success response' do
      delete promotion_path(promotion)
      expect(response).to have_http_status(:ok)
    end
  end
end
