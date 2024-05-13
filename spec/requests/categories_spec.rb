require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'POST #create' do
    context 'when user not signed in' do
      it 'redirects to home page' do
        post categories_path, params: { name: 'Category Name' }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is a admin' do
      let(:admin) { create(:user, role: create(:role, name: 'Admin')) }

      before do
        sign_in admin
      end

      it 'creates a new category' do
        post categories_path, params: { name: 'Category Name' }
        expect(response).to have_http_status(:created)
      end
    end

    context 'when user is not a admin' do
      let(:user) { create(:user, role: create(:role, name: 'Other than Admin')) }

      before do
        sign_in user
      end

      it 'redirects to home page' do
        post categories_path, params: { name: 'Category Name' }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
