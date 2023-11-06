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
    @final_countdown_date = Event.find_by(hasCountdown: true)&.date
    @current_user = User.find_by(email: session[:user_email])
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
  
    event = Event.find_by(id: params[:event_id]) 
    user = User.find_by(email: session[:user_email])

    # checks if user exists, if they dont they will be redirected to log in again
    if user.nil?
      redirect_to new_user_session_path and return
    end
  
    # Check if phone numbers match
    if user.phone_number != params[:phone_number]
      flash[:alert] = 'Phone number verification failed.'
      redirect_to user_dashboard_path
      return
    end
  
    if event
      EventsUser.create(user_id: user.id, event_id: event.id)
      redirect_to user_dashboard_path, notice: 'Successfully checked-in!'
    else
      flash[:alert] = 'Event not found with the specified ID.'
      redirect_to user_dashboard_path
    end
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
    @google_data = session[:google_data]
    @user = User.new
    @classifications = Classification.all
  end

  def create_profile
    google_data = session.delete(:google_data)

    user = User.new(google_data)
    user.phone_number = user_params[:phone_number]
    user.classification_id = user_params[:classification_id]
    # This part is for testing purposes
    if user.email.blank?
      user.email = "new_user@signedin.test"
    end
    if user.password.blank?
      user.password = "test123"
    end
    
    if user.save
      sign_in(user)
      redirect_to user_dashboard_path, notice: 'Profile created successfully.'
    else
      @user = user
      @classifications = Classification.all
      flash[:alert] = 'Error creating your profile. Please try again.'
      puts user.errors.full_messages
      render :profile_setup
    end
  end

  def events_attended
    @user = User.find_by(email: session[:user_email])

    # makes sure current stored user email is valid, otherwise user is redirected to log in again
    if @user
      @attended_events = @user.events
    else
      redirect_to new_user_session_path
    end
  end

  def upcoming_events
    @events = Event.where("date >= ?", Date.current).order(:date)
  end
  

  private

  def user_params
    params.require(:user).permit(:phone_number, :classification_id)
  end

end
