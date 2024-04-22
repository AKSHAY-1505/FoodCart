class ApplicationController < ActionController::Base

    private
    
    def after_sign_in_path_for(user)
        user.admin? ? admin_home_path : root_path
    end

end
