class UsersController < ApplicationController
    # before_action :ensure_admin, only: [:admin_dashboard, :grant_admin]
    def home
    end
    def admin_dashboard
      @users = User.all
    end
    

    def grant_admin
        user = User.find_by(email: params[:email])
        if user
          user.update(is_admin: true)
          redirect_to admin_dashboard_path, notice: "#{user.email} has been granted admin status."
        else
          redirect_to admin_dashboard_path, alert: "User with email #{params[:email]} not found."
        end
    end

    def admin_checkin
      puts "inside function"
      if request.post?
        puts "test"
        # This block will execute when the form is submitted
        
        first_name = params[:first_name]
        last_name = params[:last_name]
        email = params[:email]

        # Find a user matching the provided first name, last name, and email
        user = User.find_by(first_name: first_name, last_name: last_name, email: email)

        if user
          userId = user.id
          # Create a record in the join table
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
  
    # def ensure_admin
    #   unless current_user&.is_admin?
    #     redirect_to root_path, alert: "You are not authorized to access this page."
    #   end
    # end
  end
  