# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #add_admin' do
    it 'grants admin status to a user' do
      Classification.create(name: 'Freshman')
      classification_name = 'Freshman'
      classification = Classification.find_by(name: classification_name)
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@example.com', isAdmin: false,
                         password: 'password', phone_number: "", classification_id: classification.id)

      # Simulate a POST request to the add_admin endpoint
      post :add_admin, params: { email: user.email }

      # Check if the user's isAdmin attribute is updated to true
      user.reload
      expect(user.isAdmin).to be true
    end

    it 'handles non-existent user gracefully' do
      # Simulate a POST request with an email of a non-existent user
      post :add_admin, params: { email: 'nonexistent@example.com' }

      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).to be_present
    end
  end
end
