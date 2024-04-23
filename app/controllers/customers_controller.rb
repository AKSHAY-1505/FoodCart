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
            redirect_to new_customer_path, alert: @customer.errors.full_messages.join(', ')
        end
    end

    def edit
        @customer = Customer.find_by(user: current_user)
    end

    def update
        @customer = Customer.find_by(user: current_user)
        if @customer.update(customer_edit_params)
            redirect_to root_path, notice: "Address Updated Successfully"
        else
            flash.now[:alert] = @customer.errors.full_messages.join(', ')
            render :edit
        end
    end

    def home
    end

    private

    def customer_params
        params.require(:customer).permit(:house_number,:street,:locality,:city,:phone_number,user_attributes: [:name,:email,:password,:password_confirmation])
    end

    def customer_edit_params
        params.require(:customer).permit(:house_number,:street,:locality,:city,:phone_number)
    end
end
