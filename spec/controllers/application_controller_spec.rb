
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: current_user_name
    end
  end

  describe '#current_user_name' do
    it 'returns the full name of the user if a user is found' do
        Classification.create(name: 'Freshman')
        classification_name = 'Freshman'
        classification = Classification.find_by(name: classification_name)
        user = User.new(
          first_name: 'John',
          last_name: 'Doe',
          email: 'john.doe@example.com',
          password: 'password',
          phone_number: "",
          classification_id: classification.id
        )
        if user.save
            # User was saved successfully
        else
            # There was an error
            errors = user.errors.full_messages
            puts errors
        end
        
      session[:user_email] = user.email
      session[:user_id] = User.find_by(email: 'john.doe@example.com').id
      get :index
      expect(response.body).to eq('John Doe')
    end

    it 'returns "Unknown User" if no user is found' do
      session[:user_email] = 'nonexistent@example.com'
      get :index
      expect(response.body).to eq('Unknown User')
    end
  end
end