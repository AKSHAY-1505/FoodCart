require 'rails_helper'

RSpec.describe 'OrderItems', type: :request do
  let(:food) { create(:food) }
  let(:customer) { create(:user, role: create(:role, name: 'Customer')) }
  let(:valid_params) do
    { order_item: { food_id: food.id, quantity: 1 } }
  end

  describe 'POST #create' do
    let(:order_item) { build(:order_item) }

    before do
      allow_any_instance_of(Services::CartItemService::CartItemCreator).to receive(:create_cart_item).and_return(order_item)
    end

    context 'customer signed in' do
      before do
        sign_in customer
      end
      it 'responds with created status' do
        post order_items_path, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'it creates a cart item' do
        expect do
          post order_items_path, params: valid_params
        end.to change(OrderItem, :count).by(1)
      end
    end

    context 'user not signed in' do
      it 'redirects to root path' do
        post order_items_path, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'it creates a cart item' do
        expect do
          post order_items_path, params: valid_params
        end.to change(OrderItem, :count).by(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:order_item) { create(:order_item) }

    context 'customer signed in' do
      before do
        sign_in customer
        order_item
      end

      it 'responds with a success response' do
        delete order_item_path(order_item)
        expect(response).to have_http_status(:ok)
      end
      it 'deletes order item' do
        expect do
          delete order_item_path(order_item)
        end.to change(OrderItem, :count).by(-1)
      end
    end

    context 'user not signed in' do
      before do
        order_item
      end

      it 'redirects to root path' do
        delete order_item_path(order_item)
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'deletes order item' do
        expect do
          delete order_item_path(order_item)
        end.to change(OrderItem, :count).by(0)
      end
    end
  end
end
