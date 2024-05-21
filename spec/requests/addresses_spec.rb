require 'rails_helper'

RSpec.describe 'AddressesController', type: :request do
  describe 'POST #create' do
    context 'when user not signed in' do
      it 'redirects to home page' do
        post addresses_path,
             params: { address: { house_number: '123', street_name: 'Main St', locality: 'City', city: 'State',
                                  phone_number: '1234567890' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is a customer' do
      let(:customer) { create(:user, role: create(:role, name: 'Customer')) }

      before do
        sign_in customer
      end

      it 'creates a new address' do
        post addresses_path,
             params: { address: { house_number: '123', street_name: 'Main St', locality: 'City', city: 'State',
                                  phone_number: '1234567890' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'when user is not a customer' do
      let(:user) { create(:user, role: create(:role, name: 'Other than customer')) }

      before do
        sign_in user
      end

      it 'redirects to home page' do
        post addresses_path,
             params: { address: { house_number: '123', street_name: 'Main St', locality: 'City', city: 'State',
                                  phone_number: '1234567890' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
