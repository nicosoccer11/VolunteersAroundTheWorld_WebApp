require 'rails_helper'

RSpec.feature 'Admin Check-In', type: :feature do
  scenario 'admin checks in a user' do
    # Create any necessary data (e.g., user, event) in the database
    user = User.create(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john.doe@example.com',
      isAdmin: true,  # Assuming this user is an admin
      password: 'password'  # Assuming you have password authentication
    )

    event = Event.create(
      name: 'Test Event',
      date: Date.today
    )

    # Visit the admin check-in page
    visit admin_checkin_path

    # Fill in the form with user details and select the event
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john.doe@example.com'
    select 'Test Event', from: 'Select Event'

    # Submit the form
    click_button 'Check-In'

    # Add assertions to check for expected behavior
    expect(page).to have_content('User checked in successfully')  # Replace with your flash message

  end

  scenario 'admin checks in a non-existant user' do
    user = User.create(
      first_name: 'no',
      last_name: 'Doe',
      email: 'fake@example.com',
      isAdmin: true,
      password: 'password'
    )

    event = Event.create(
      name: 'Test Event',
      date: Date.today
    )

    # Visit the admin check-in page
    visit admin_checkin_path

    # Fill in the form with user details and select the event
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'aiodaiod@example.com'
    select 'Test Event', from: 'Select Event'

    # Submit the form
    click_button 'Check-In'

    # Add assertions to check for expected behavior
    expect(page).to have_content('No user found with the specified first name, last name, and email.')  # Replace with your flash message

  end
end
