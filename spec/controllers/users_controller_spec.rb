require 'rails_helper'

RSpec.describe 'Admin Check-In', type: :feature do

  it 'allows an admin to check in a user' do
    visit admin_checkin_path

    # Fill in the form fields
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'test@tamu.edu'

    # Select an event from the dropdown by its visible texts
    select("Test Event", from: "Select Event").select_option

    click_button 'Check-In'

    expect(page).to have_content('User checked in successfully.')
  end
end