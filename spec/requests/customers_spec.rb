require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  let(:customer) { create(:user, role: create(:role, name: 'Customer')) }
  let(:food) { create(:food) }

  describe 'GET #home' do
    context 'when user is an Customer' do
      before do
        sign_in customer
        get root_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:home)
      end
    end

    context 'when user is not an customer' do
      let(:user) { create(:user, role: create(:role, name: 'Other than customer')) }

      before do
        sign_in user
        get root_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:home)
      end
    end

    context 'when user is not signed in' do
      before do
        get root_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:home)
      end
    end
  end

  describe 'GET #view_food' do
    context 'when user is an Customer' do
      before do
        sign_in customer
        get view_food_path(food)
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:view_food)
      end
    end

    context 'when user is not an customer' do
      let(:user) { create(:user, role: create(:role, name: 'Other than customer')) }

      before do
        sign_in user
        get view_food_path(food)
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:view_food)
      end
    end

    context 'when user is not signed in' do
      before do
        get view_food_path(food)
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:view_food)
      end
    end
  end

  describe 'GET #customer_orders' do
    context 'when user is an Customer' do
      before do
        sign_in customer
        get customer_orders_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the customer home page' do
        expect(response).to render_template(:customer_orders)
      end
    end

    context 'when user is not an customer' do
      let(:user) { create(:user, role: create(:role, name: 'Other than customer')) }

      before do
        sign_in user
        get customer_orders_path
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not signed in' do
      before do
        get customer_orders_path
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
