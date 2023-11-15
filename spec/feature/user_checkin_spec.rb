require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #checkin' do
    it 'redirects to user dashboard on successful check-in' do
      # Mock a user and event 
      Classification.create(name: 'Freshman')
      classification_name = 'Freshman'
      classification = Classification.find_by(name: classification_name)
      # Create any necessary data in the database
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        isAdmin: true,
        password: 'password',
        phone_number: "1",
        classification_id: classification.id
      )

      event = Event.create(
        name: 'Test Event',
        date: Date.today,
        hasCountdown: false
      )
      # Set up your session data 
      session[:user_email] = user.email

      # Make a POST request to the checkin action
      post :checkin, params: { event_id: event.id, phone_number: "1" }

      # Assert the response
      expect(response).to redirect_to(user_dashboard_path)
    end

    it 'redirects to user dashboard with an alert on invalid event' do
      # Mock a user and event 
      Classification.create(name: 'Freshman')
      classification_name = 'Freshman'
      classification = Classification.find_by(name: classification_name)
      # Create any necessary data in the database
      user = User.create(
       first_name: 'John',
       last_name: 'Doe',
       email: 'john.qoe@example.com',
       isAdmin: true,
       password: 'password',
       phone_number: "",
       classification_id: classification.id
      )

      event = Event.create(
       name: 'Test Event',
       date: Date.today,
       hasCountdown: false
      )
      # Set up your session data 
      session[:user_email] = user.email

      # Make a POST request to the checkin action with an invalid event_id
      post :checkin, params: { event_id: event.id, phone_number: "123-123-1234" }

      # Assert the response
      expect(response).to redirect_to(user_dashboard_path)
      expect(flash[:alert]).to eq('Phone number verification failed.')
    end
  end
end
