module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      user = User.from_omniauth(auth)

      if user.persisted?
        flash[:success] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
        sign_in_and_redirect user, event: :authentication
        tempUser = User.find_by(email: user.email)
        session[:user_email] = auth.info.email
        if tempUser
          puts 'User already exists'
          session[:user_email] = auth.info.email
        else
          session[:new_user] = true
          session[:user_email] = auth.info.email
          User.create!(
            first_name: auth.info.first_name,
            last_name: auth.info.last_name,
            email: auth.info.email,
            isAdmin: false,
            provider: auth.provider,
            uid: auth.uid,
            avatar_url: auth.info.avatar_url,
            password: 'password',
            phone_number: "",
          )
        end
      else
        session[:google_data] = user_data_from_auth
        redirect_to profile_setup_path
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
    end

    private

    def auth
      @auth ||= request.env['omniauth.auth']
    end
    #might not need
    def user_data_from_auth
      {
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        email: auth.info.email,
        provider: auth.provider,
        uid: auth.uid,
        avatar_url: auth.info.image,
        password: Devise.friendly_token[0,20]
      }
    end
  end
end
