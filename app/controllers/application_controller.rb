# frozen_string_literal: true

# ApplicationController is the base class for all controllers in your application.
# It provides common methods and filters that can be used by other controllers.
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

    
  def current_user_name
    user_email = session[:user_email]
    user = User.find_by(email: user_email)
    # The following deals with gmail not requiring a user to have two names. In the case that only one name or no name appears, we deal with
    # how we want to display the name below.
    if user.present?
      fullName = [user.first_name, user.last_name].compact.join(" ")
      fullName.present? ? fullName : 'Unknown User'
    else
      'Unknown User'
    end
  end
  helper_method :current_user_name


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to users_home_path, alert: 'You must be logged in to access this page.' unless logged_in?
  end
  def after_sign_in_path_for(resource)
    if resource.isAdmin?
      admin_dashboard_path
    else
      user_dashboard_path
    end
  end
  def after_sign_out_path_for(resource_or_scope)
    users_home_path
  end
end
