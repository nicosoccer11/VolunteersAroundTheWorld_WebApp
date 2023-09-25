class UsersController < ApplicationController
    def home
    end
    
    def admin_dashboard
      @users = User.all
      @events = Event.all
    end

    def user_dashboard
      @events = Event.all
    end
    
    def checkin
      @events = Event.all 
  
      if request.post?
        event = Event.find(params[:event_id])
        current_user.events << event 
        redirect_to user_dashboard_path, notice: 'Successfully checked-in!'

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
      if request.post?
        
        first_name = params[:first_name]
        last_name = params[:last_name]
        email = params[:email]

        user = User.find_by(first_name: first_name, last_name: last_name, email: email)

        if user
          userId = user.id
          EventsUser.create(user_id: userId, event_id: params[:event_id])
          flash[:notice] = 'User checked in successfully.'
          redirect_to admin_dashboard_path
        else
          flash[:alert] = 'No user found with the specified first name, last name, and email.'
          redirect_to admin_checkin_path
        end
      else
        
      end
    end
    
  
    private

  end
  