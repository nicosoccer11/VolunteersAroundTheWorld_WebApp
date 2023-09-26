# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :ensure_admin, only: [:admin_dashboard, :grant_admin]
  def home; end

  def admin_dashboard
    @users = User.all
    @events = Event.all
  end

  def user_dashboard
    @events = Event.all
  end

  def checkin
    @events = Event.all
    @test = current_user
    return unless request.post?

    Event.find(params[:event_id])
    user = User.find_by(email: $current_user_email)
    EventsUser.create(user_id: user.id, event_id: params[:event_id])
    redirect_to user_dashboard_path, notice: 'Successfully checked-in!'
  end

  def add_admin
    email = params[:email]
    user = User.find_by(email:)

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

  # def ensure_admin
  #   unless current_user&.is_admin?
  #     redirect_to root_path, alert: "You are not authorized to access this page."
  #   end
  # end
end
