# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :ensure_admin, only: [:admin_dashboard, :grant_admin]
  before_action :redirect_new_users_to_profile_setup, only: :user_dashboard
  def home; end

  def admin_dashboard
    @users = User.all
    @events = Event.all
  end

  def user_dashboard
    @events = Event.all
  end

  def redirect_new_users_to_profile_setup
    if session[:new_user]
      redirect_to profile_setup_path
    end
  end

  def checkin
    @events = Event.all
    @test = current_user
    return unless request.post?

    Event.find(params[:event_id])
    user = User.find_by(email: session[:user_email])
    EventsUser.create(user_id: user.id, event_id: params[:event_id])
    redirect_to user_dashboard_path, notice: 'Successfully checked-in!'
  end

  def add_admin
    email = params[:email]
    user = User.find_by(email: email)

    if user
      user.update(isAdmin: true)
      redirect_to admin_dashboard_path, notice: "#{user.email} has been granted admin status."
    else
      redirect_to admin_dashboard_path, alert: "User with email #{email} not found."
    end
  end

  def admin_checkin
    return unless request.post?

    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]

    user = User.find_by(first_name:, last_name:, email:)

    if user
      userId = user.id
      EventsUser.create(user_id: userId, event_id: params[:event_id])
      flash[:notice] = 'User checked in successfully.'
      redirect_to admin_dashboard_path
    else
      flash[:alert] = 'No user found with the specified first name, last name, and email.'
      redirect_to admin_checkin_path
    end
  end

  def profile_setup
    @user = User.new
    @classifications = Classification.all  # Load classification options here
  end

  def create_profile
    user = User.find_by(email: session[:user_email])

    if user
      user.update(phone_number: user_params[:phone_number])
      user.update(classification_id: user_params[:classification_id])
    else
      flash[:failure] = 'Could not find user'
    end
    
    


    session[:new_user] = nil
    flash[:success] = 'Profile updated successfully.'
    redirect_to user_dashboard_path
  end

  def events_attended
    puts "HERE COMES THE SESSION EMAIL"
    puts "#{session[:user_email]}"
    @user = User.find_by(email: session[:user_email])
    @attended_events = @user.events.includes(:users)
  end

  # def ensure_admin
  #   unless current_user&.is_admin?
  #     redirect_to root_path, alert: "You are not authorized to access this page."
  #   end
  # end

  private

  def user_params
    params.require(:user).permit(:phone_number, :classification_id)
  end
end
