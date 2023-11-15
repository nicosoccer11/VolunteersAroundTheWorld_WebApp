# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    def destroy
      revoke_google_oauth_token
      super # This will handle the regular logout process for Devise
    end

    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end

    def after_sign_in_path_for(resource)
      if resource.isAdmin?
        admin_dashboard_path
      else
        user_dashboard_path
      end
    end

    private

    def revoke_google_oauth_token
      return unless session[:user_email].present?

      user_email = session[:user_email]
      user = User.find_by(email: user_email)
      user.update(google_oauth_token: nil) if user && user.google_oauth_token.present?

      session.delete(:user_email)
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
