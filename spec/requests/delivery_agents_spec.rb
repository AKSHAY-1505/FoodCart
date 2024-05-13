require 'rails_helper'

RSpec.describe 'DeliveryAgentsController', type: :request do
  let(:admin) { create(:user, role: create(:role, name: 'Admin')) }
  let(:delivery_agent_role) { create(:role, name: 'Delivery Agent') }
  let(:delivery_agent) { create(:user, role: delivery_agent_role) }

  describe 'GET #new' do
    context 'when user is an admin' do
      before do
        delivery_agent_role
        sign_in admin
        get new_delivery_agent_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns a new user to @delivery_agent' do
        expect(assigns(:delivery_agent)).to be_a_new(User)
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Admin')) }

      before do
        sign_in user
        get new_delivery_agent_path
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is an admin' do
      before do
        sign_in admin
      end

      context 'with valid params' do
        let(:valid_params) do
          { user: { name: 'Name', email: 'test@mail.com', password: 'password', password_confirmation: 'password',
                    role_id: delivery_agent_role.id } }
        end

        it 'creates a new delivery agent' do
          expect do
            post delivery_agents_path, params: valid_params
          end.to change(User, :count).by(1)
        end

        it 'redirects to admin home page' do
          post delivery_agents_path, params: valid_params
          expect(response).to redirect_to(admin_home_path)
        end
      end

      context 'with invalid params' do
        let(:invalid_params) do
          { user: { name: 'Name', email: 'invalid_email', password: 'password', password_confirmation: 'password' } }
        end

        it 'does not create a new delivery agent' do
          expect do
            post delivery_agents_path, params: invalid_params
          end.not_to change(User, :count)
        end

        it 'redirects to delivery agent create form page' do
          post delivery_agents_path, params: invalid_params
          expect(response).to redirect_to(new_delivery_agent_path)
        end
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Admin')) }

      before do
        sign_in user
      end

      it 'redirects to root path' do
        post delivery_agents_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #home' do
    context 'when user is a delivery agent' do
      before do
        sign_in delivery_agent
        create_list(:order_delivery_agent, 3, user: delivery_agent, delivered_at: nil)
        get delivery_agent_home_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the home template' do
        expect(response).to render_template(:home)
      end

      it 'assigns active orders to @active_orders' do
        expect(assigns(:active_orders).count).to eq(3)
      end

      it 'assigns order statuses to @statuses' do
        expect(assigns(:statuses)).to eq(Order.statuses)
      end
    end

    context 'when user is not a delivery agent' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Delivery Agent')) }

      before do
        sign_in user
        get delivery_agent_home_path
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
