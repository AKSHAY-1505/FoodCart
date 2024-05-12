require 'rails_helper'

RSpec.describe 'AdminsController', type: :request do
  let(:admin) { create(:user, role: create(:role, name: 'Admin')) }

  describe 'GET #home' do
    context 'when user is an admin' do
      before do
        sign_in admin
        get admin_home_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the admin home page' do
        expect(response).to render_template(:home)
      end
    end

    context 'when user is not an admin' do
      let(:non_admin_user) { create(:user, role: create(:role, name: 'Other than admin')) }

      before do
        sign_in non_admin_user
        get admin_home_path
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
