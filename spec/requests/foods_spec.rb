require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  let(:admin) { create(:user, role: create(:role, name: 'Admin')) }
  let(:category) { create(:category) }
  let(:food) { create(:food) }
  let(:valid_params) do
    { food: { name: 'Name', price: 100, quantity: 10, description: 'Description', category_id: category.id } }
  end

  describe 'GET #index' do
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns a success response' do
        get foods_path
        expect(response).to be_successful
      end

      it 'renders the index template' do
        get foods_path
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to root path' do
        get foods_path
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not a admin' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Admin')) }

      before { sign_in user }

      it 'redirects to root path' do
        get foods_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when user is admin' do
      before do
        sign_in admin
        get food_path(food)
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not signed in' do
      it 'returns a success response' do
        get food_path(food)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'user is a admin' do
      before { sign_in admin }

      it 'creates a food' do
        expect do
          post foods_path, params: valid_params
        end.to change(Food, :count).by(1)
      end

      it 'returns a success response' do
        post foods_path, params: valid_params
        expect(response).to be_successful
      end
    end

    context 'user not signed in' do
      it 'creates a food' do
        expect do
          post foods_path, params: valid_params
        end.to change(Food, :count).by(0)
      end

      it 'redirects to root path' do
        post foods_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATH #update' do
    context 'user is a admin' do
      before { sign_in admin }

      it 'returns a success response' do
        patch food_path(food), params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'user not signed in' do
      it 'redirects to root path' do
        patch food_path(food), params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user is a admin' do
      before do
        sign_in admin
        food
      end

      it 'deletes a food' do
        expect do
          delete food_path(food)
        end.to change(Food, :count).by(-1)
      end

      it 'returns a success response' do
        delete food_path(food)
        expect(response).to be_successful
      end
    end

    context 'user not signed in' do
      before do
        food
      end

      it 'deletes a food' do
        expect do
          delete food_path(food)
        end.to change(Food, :count).by(0)
      end

      it 'redirects to root path' do
        delete food_path(food)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
