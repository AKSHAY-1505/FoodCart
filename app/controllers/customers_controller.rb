class CustomersController < ApplicationController 
    def new
        @customer = Customer.new
        @customer.build_user
    end

    def create
        @customer = Customer.new(customer_params)
        user = @customer.user

        if @customer.save
            sign_in(user)
            redirect_to root_path, notice: "Signed in Successfully!"
        else
            render :new, alert: "Error creating an account!"
        end
    end

    def home
    end

    private

    def customer_params
        params.require(:customer).permit(:house_number,:street,:locality,:city,:phone_number,user_attributes: [:name,:email,:password,:password_confirmation])
    end
end
