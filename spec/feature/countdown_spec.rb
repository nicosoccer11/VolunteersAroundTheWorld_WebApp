require 'rails_helper'

RSpec.feature 'Create Final Countdown Event', type: :feature do
    scenario 'Admin creates a new final countdown event' do
    
        visit new_final_countdown_event_path

        fill_in 'Name', with: 'New Year Countdown'
        fill_in 'Date', with: '2023-12-31'

        click_button 'Create Final Countdown Event'

        expect(page).to have_content('Final Countdown Event created successfully')
    end

    scenario 'Admin tries to create a final countdown event when one already exists' do

        visit new_final_countdown_event_path

        # Create an existing final countdown event
        Event.create(name: 'Event 1', date: Date.today, hasCountdown: true)
        fill_in 'Name', with: 'New Year Countdown'
        fill_in 'Date', with: '2023-12-31'

        click_button 'Create Final Countdown Event'

        expect(page).to have_content('Final Countdown Event created successfully')
    end
end