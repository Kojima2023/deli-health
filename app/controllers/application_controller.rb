class ApplicationController < ActionController::Base       
    before_action :configure_permitted_parameters, if: :devise_controller?
    after_action  :store_location
 
    def store_location
      if (request.fullpath != new_user_registration_path &&
          request.fullpath != new_user_session_path &&
          # request.fullpath != "/users/password" &&
          request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
          !request.xhr?)
        session[:previous_url] = request.fullpath 
      end
    end
   
    def after_sign_in_path_for(resource)
      if (session[:previous_url] == root_path)
        super
      else
        session[:previous_url] || root_path
      end
    end

    def after_sign_out_path_for(resource)
      tomorecipes_path
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :user_url])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image, :user_url])
    end

    def after_update_path_for(resource)
        user_path(current_user.id)
    end

    

end
