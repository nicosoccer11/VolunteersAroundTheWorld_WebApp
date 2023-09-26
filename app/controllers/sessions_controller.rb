# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    # Extract the auth information from the callback
    auth = request.env['omniauth.auth']

    # Find or create a user based on the auth information
    user = User.find_by(email: auth['info']['email']) || User.create(email: auth['info']['email'])

    # Store the user ID in the session to keep them logged in
    session[:user_id] = user.id
    # Check if the user is an admin and redirect accordingly
    if user.is_admin?
      redirect_to admin_dashboard_path, notice: 'Successfully signed in as Admin!'
    else
      redirect_to root_path, notice: 'Successfully signed in!'
    end
  end

  def destroy
    # Clear the user ID from the session to log them out
    session[:user_id] = nil

    # Redirect to the main page with a success message
    redirect_to root_path, notice: 'Successfully signed out!'
  end
end
