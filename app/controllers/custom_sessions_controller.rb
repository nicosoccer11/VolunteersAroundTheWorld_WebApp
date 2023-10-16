class CustomSessionsController < ApplicationController
    def logout
      sign_out(current_user) # Devise logout
  
      # Redirect to the desired page after logout
      redirect_to root_path
    end
  end
  