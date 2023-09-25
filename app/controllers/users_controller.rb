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
        
        # Extract user_id and event_id from the form parameters
        user_id = params[:admin_checkin][:user_id]
        event_id = params[:admin_checkin][:event_id]
    
        # Add logic to create a record in the join table
        if user_id.present? && event_id.present?
          EventsUser.create(user_id: user_id, event_id: event_id)
          flash[:notice] = 'User checked in successfully.'
          redirect_to admin_dashboard_path # Redirect after form submission
        else
          flash[:alert] = 'Please select a user and an event.'
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
  