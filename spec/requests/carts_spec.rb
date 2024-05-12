require 'rails_helper'

RSpec.describe 'CartsController', type: :request do
  let(:role) { create(:role, name: 'Customer') }
  let(:customer) { create(:user, role: role) }

  describe 'GET #show' do
    context 'when user is authenticated' do
      before { sign_in customer }

      it 'returns a success response' do
        get cart_path(customer)
        expect(response).to be_successful
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to root path' do
        get cart_path(customer)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user tries to access another user\'s cart' do
      let(:another_customer) { create(:user, role: role) }

      before { sign_in customer }

      it 'redirects to root path' do
        get cart_path(another_customer)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST /apply_coupon' do
    let(:user) { create(:user) }
    let(:coupon) { create(:coupon, discount: 50, min_amount: 100) }

    before do
      sign_in user
    end

    context 'with a valid coupon code and eligible subtotal' do
      let(:cart_items) { create_list(:order_item, 2, user: user, subtotal: 60, ordered: false) }

      it 'applies the coupon discount and returns the updated cart summary with :ok status' do
        cart_items
        post apply_coupon_path, params: { code: coupon.code }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(partial: 'carts/_cart_summary')
        expect(assigns(:cart_details)[:coupon_discount]).to eq(coupon.discount)
      end
    end

    context 'with a valid coupon code but ineligible subtotal' do
      let(:cart_items) { create_list(:order_item, 2, user: user, subtotal: 40, ordered: false) }

      it 'does not apply the coupon discount and returns the updated cart summary with :unprocessable_entity status' do
        cart_items
        post apply_coupon_path, params: { code: coupon.code }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(partial: 'carts/_cart_summary')
        expect(assigns(:cart_details)[:coupon_discount]).to eq(0)
      end
    end

    context 'with an invalid coupon code' do
      it 'does not apply any discount and returns the updated cart summary with :unprocessable_entity status' do
        post apply_coupon_path, params: { code: 'invalid_code' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(partial: 'carts/_cart_summary')
        expect(assigns(:cart_details)[:coupon_discount]).to eq(0)
      end
    end
  end
end
