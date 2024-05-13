require 'rails_helper'

RSpec.describe 'Coupons', type: :request do
  let(:admin) { create(:user, role: create(:role, name: 'Admin')) }

  describe 'GET #index' do
    context 'when user is admin' do
      before { sign_in admin }

      it 'returns a success response' do
        get coupons_path
        expect(response).to be_successful
      end

      it 'renders the index template' do
        get coupons_path
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to root path' do
        get coupons_path
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not a admin' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Admin')) }

      before { sign_in user }

      it 'redirects to root path' do
        get coupons_path
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
          { coupon: { code: 'COUPON10', discount: 10, min_amount: 100, from_date: Date.today,
                      to_date: Date.today + 1.week } }
        end

        it 'creates a new coupon' do
          expect do
            post coupons_path, params: valid_params
          end.to change(Coupon, :count).by(1)
        end

        it 'renders the coupon partial' do
          post coupons_path, params: valid_params
          expect(response).to render_template(partial: 'coupons/_coupon')
        end
      end

      context 'with invalid params' do
        let(:invalid_params) do
          { coupon: { code: nil, discount: -10, min_amount: -100, from_date: nil, to_date: nil } }
        end

        it 'does not create a new coupon' do
          expect do
            post coupons_path, params: invalid_params
          end.not_to change(Coupon, :count)
        end

        it 'returns an unprocessable entity status' do
          post coupons_path, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Admin')) }

      before do
        sign_in user
      end

      it 'redirects to root path' do
        post coupons_path,
             params: { coupon: { code: 'COUPON10', discount: 10, min_amount: 100, from_date: Date.today,
                                 to_date: Date.today + 1.week } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
