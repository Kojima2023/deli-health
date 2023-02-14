class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_account_update_params, only: [:update]
  
    protected

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
  
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def edit
      if user.save                                                        
        redirect_to :action => "show"
      else
        redirect_to :action => "edit"
      end
    end

    def after_update_path_for(resource)
      user_profile_path(current_user)
    end
end