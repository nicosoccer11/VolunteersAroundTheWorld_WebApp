# frozen_string_literal: true

# The SessionsController manages user authentication and sessions within the application.
# It handles user sign-in and sign-out using OmniAuth-based authentication.
class SessionsController < ApplicationController
  def create
    # Extract the auth information from the callback
    auth = request.env['omniauth.auth']

    # Find or create a user based on the auth information
    user = User.find_by(email: auth['info']['email']) || User.create(email: auth['info']['email'])

    # Store the user ID in the session to keep them logged in
    session[:user_id] = user.id
    # Check if the user is an admin and redirect accordingly
    if resource.isAdmin?
      admin_dashboard_path
    else
      user_dashboard_path
    end
  end

  def logout_google
      # Revoke the Google OAuth token
      revoke_google_oauth_token
  
      # Redirect to the homepage or a logged-out page
      redirect_to users_home_path, notice: 'Logged out of Google successfully'
  end

  def revoke_google_oauth_token
    return unless session[:user_email].present?
  
    # Get the user's Google OAuth token from your session or database
    user_email = session[:user_email]
    user = User.find_by(email: user_email)
  
    if user && user.google_oauth_token.present?
      # Revoke the token using OmniAuth's built-in method
      user.update(google_oauth_token: nil) # Clear the token from your user model
    end
  
    # Clear any session data
    session.delete(:user_email)
  end

end
