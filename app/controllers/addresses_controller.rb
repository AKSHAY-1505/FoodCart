class AddressesController < ApplicationController
  def create
    @address = Address.new(address_params)

    if @address.save
      render json: { address: @address }, status: :created
    else
      render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(:house_number, :street_name, :locality, :city, :phone_number, :customer_id)
  end
end
