require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:admin) { create(:user, role: create(:role, name: 'Admin')) }
  let(:customer) { create(:user, role: create(:role, name: 'Customer')) }
  let(:address) { create :address }
  let(:valid_params) { { address_id: address.id } }

  describe 'GET #index' do
    context 'admin signed in' do
      before do
        sign_in admin
      end

      it 'returns a success response ' do
        get orders_path
        expect(response).to be_successful
      end

      it 'renders index template' do
        get orders_path
        expect(response).to render_template(:index)
      end
    end

    context 'user not signed in' do
      it 'redirects to root path' do
        get orders_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #new' do
    context 'customer signed in' do
      before do
        sign_in customer
      end
      it 'returns a success response' do
        get new_order_path
        expect(response).to be_successful
      end

      it 'renders new template' do
        get new_order_path
        expect(response).to render_template(:new)
      end
    end

    context 'user not signed in'
    it 'redirects to root path' do
      get new_order_path
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST #create' do
    before do
      allow_any_instance_of(Services::CartService::CartTotalCalculator).to receive(:calculate_total).and_return({ subtotal: 400, delivery_charge: 30, discount: 100, total: 330 }) # rubocop:disable Layout/LineLength
    end

    context 'customer signed in' do
      before do
        sign_in customer
      end
      it 'creates a new order' do
        expect do
          post orders_path, params: valid_params
        end.to change(Order, :count).by(1)
      end

      it 'redirects to root path' do
        post orders_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'user not signed in' do
      it 'redirects to root path' do
        post orders_path, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) { { status: 'delivery_agent_assigned' } }
    let(:order) { create(:order) }
    let(:order_delivery_agent) { create(:order_delivery_agent, order: order) }

    context 'admin signed in' do
      before do
        sign_in admin
        order
        order_delivery_agent
      end
      it 'returns a success response with valid attributes' do
        patch order_path(order), params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'updates is_active to false when status updated to delivered' do
        patch order_path(order), params: { status: 'delivered' }
        expect(order.reload.is_active).to be_falsey # reload the order object in memory to reflect the changes made in the update
      end
    end

    context 'user not signed in' do
      it 'redirects to root path' do
        patch order_path(order), params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #assign_agent' do
    let(:delivery_agent) { create(:user, role: create(:role, name: 'Delivery Agent')) }
    let(:valid_params) { { delivery_agent: delivery_agent.id } }
    let(:order) { create(:order) }

    context 'admin signed in' do
      before do
        sign_in admin
        delivery_agent
        order
      end
      it 'returns a success response with valid attributes' do
        patch assign_agent_path(order), params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'updates status to delivery agent assigned' do
        patch assign_agent_path(order), params: valid_params
        expect(order.reload.status).to eq('delivery_agent_assigned') # reload the order object in memory to reflect the changes made in the update
      end
    end

    context 'user not signed in' do
      it 'redirects to root path' do
        patch order_path(order), params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
