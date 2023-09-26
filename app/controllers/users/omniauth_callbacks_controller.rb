# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    # def twitter
    # end

    def google_oauth2
      user = User.from_omniauth(auth)

      if user.present?
        sign_out_all_scopes
        flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect user, event: :authentication
        puts 'SETTING EMAIL right nowNOW'
        $current_user_email = auth.info.email
        tempUser = User.find_by(email: user.email)
        if tempUser
          puts 'User already exists'
        else
          User.create!(
            first_name: auth.info.first_name,
            last_name: auth.info.last_name,
            email: auth.info.email,
            isAdmin: false,
            provider: auth.provider,
            uid: auth.uid,
            avatar_url: auth.info.avatar_url,
            password: 'password'
          )
        end
      else
        flash[:alert] =
          t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
        redirect_to new_user_session_path
      end
    end

    # More info at:
    # https://github.com/heartcombo/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || user_dashboard_path
    end

    private

    # def from_google_params
    #   @from_google_params ||= {
    #     uid: auth.uid,
    #     email: auth.info.email,
    #     full_name: auth.info.name,
    #     avatar_url: auth.info.image
    #   }
    # end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
