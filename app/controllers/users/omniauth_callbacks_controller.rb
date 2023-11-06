module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      user = User.from_omniauth(auth)
      
      
      
      #
      if user.persisted?
        # The following if statement prevents non-tamu emails from logging in
        if !auth.info.email.ends_with?('@tamu.edu')
          redirect_to after_sign_out_path_for(user), alert: 'Only @tamu.edu email addresses are allowed.' and return
        end
        # the following notifies the user of a successful login and redirects them to the correct page
        flash[:success] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
        sign_in user, event: :authentication   
        redirect_to after_sign_in_path_for(user) 
        tempUser = User.find_by(email: user.email)
        session[:user_email] = auth.info.email
        # Checks if user exists and creates a new one if they do not
        if tempUser
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
      # redirects new users to a profile set up page
      else
        session[:google_data] = user_data_from_auth
        redirect_to profile_setup_path
      end
    end 

    protected
    # function to redirct on a failed log in
    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
    end

    private

    def auth
      @auth ||= request.env['omniauth.auth']
    end
   
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
