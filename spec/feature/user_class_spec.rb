require 'rails_helper'

RSpec.feature 'User Check-In', type: :feature do
    scenario "user inputs phone number and selects classification" do
        # Fill in classification table
        Classification.create(name: 'Freshman')
        unless Classification.exists?(name: 'Sophomore')
            Classification.create(name: 'Sophomore')
        end
        Classification.create(name: 'Junior')
        Classification.create(name: 'Senior')
        Classification.create(name: 'Super Senior')
        Classification.create(name: 'Grad Student')
        classification_name = 'Freshman'
        classification = Classification.find_by(name: classification_name)

        # Create test user
        user = User.create(
            first_name: 'John',
            last_name: 'Doe',
            email: 'no_user@signedin.test',
            isAdmin: true, 
            password: 'password',
            phone_number: "",
            classification_id: classification.id
        )


        # Simulate the user logging in through google oauth
        page.driver.browser.set_cookie("user_email=no_user@signedin.test")

        # Enact actual test
        visit profile_setup_path
        fill_in 'Phone Number', with: '222-222-2222'
        select 'Sophomore', from: "Classification"

        click_button "Complete Profile"
        
        expect(page).to have_content('Profile created successfully.')
    end
end