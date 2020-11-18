class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception, prepend: true
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
   
    # Implementation of strong params for allowing a user to create an account
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :first_name, :last_name, :date_of_birth, :email, :password, :password_confirmation)}
    end
end
