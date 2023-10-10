# frozen_string_literal: true

# ApplicationController is the base class for all controllers in your application.
# It provides common methods and filters that can be used by other controllers.
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?



  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to root_path, alert: 'You must be logged in to access this page.' unless logged_in?
  end
end
