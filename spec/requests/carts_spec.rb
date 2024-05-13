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

    context 'when a valid coupon code is provided' do
      before do
        allow_any_instance_of(Services::CartService::CartTotalCalculator).to receive(:calculate_total).and_return({ coupon_discount: coupon.discount })
        # allow(Services::CartService::CartTotalCalculator).to receive(:new).and_return(double('CartTotalCalculator',calculate_total: { coupon_discount: coupon.discount }))
      end

      it 'applies the coupon discount' do
        post apply_coupon_path, params: { code: coupon.code }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a invalid coupon code is provided' do
      before do
        allow_any_instance_of(Services::CartService::CartTotalCalculator).to receive(:calculate_total).and_return({ coupon_discount: 0 })
      end

      it 'applies the coupon discount' do
        post apply_coupon_path, params: { code: coupon.code }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
