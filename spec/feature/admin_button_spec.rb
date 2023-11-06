require 'rails_helper'
require "rack_session_access/capybara"

RSpec.feature 'User Dashboard' do
  context 'Admin User' do
    

    before do
      visit admin_dashboard_path
    end

    scenario 'can see "User Dashboard" link' do
      expect(page).to have_css('.bottom-left-link', text: 'User Dashboard')
    end

    scenario 'can access user dashboard' do
      click_link 'User Dashboard'
      expect(current_path).to eq(user_dashboard_path)
    end

    scenario 'can access admin dashboard' do
      Classification.create(name: 'Freshman')
      classification_name = 'Freshman'
      classification = Classification.find_by(name: classification_name)
      # Create Admin user
      User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'admin@tamu.edu',
        isAdmin: true, # Assuming this user is an admin
        password: 'password',
        phone_number: "",
        classification_id: classification.id
      )
      # Set session variable to track current admin user
      page.set_rack_session(user_email: 'admin@tamu.edu')
      visit user_dashboard_path
      expect(page).to have_css('.user-button', text: 'Admin Dashboard')
    end
  end

  context 'Regular User' do

    before do
      visit user_dashboard_path
    end

    scenario 'cannot see "Admin Dashboard" link' do
      expect(page).not_to have_link('Admin Dashboard', href: admin_dashboard_path)
    end
  end
end
