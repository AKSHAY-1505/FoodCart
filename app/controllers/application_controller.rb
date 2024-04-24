class ApplicationController < ActionController::Base
    helper_method :current_customer
    
    def current_customer
        if current_user&.customer?
            current_user.customer
        end
    end

    private
    
    def after_sign_in_path_for(user)
        user.admin? ? admin_home_path : root_path
    end
end
