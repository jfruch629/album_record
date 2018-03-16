require 'spec_helper'
require 'rails_helper'

feature 'user signs up', %Q{
  As a prospective user,
  I want to create an account,
  So that I can post items and review them
 } do


  # ACCEPTANCE CRITERIA
  # • I must provide a first name, last name, email, password
  # • The email must be in correct format
  # • I must confirm the password chosen. If these do not match, present error message
  # • If I do not provide all fields, I will be prompted with an error message
  # • If all fields are successfully provided, the user will be logged in & provided with message to alert

  scenario 'providing valid and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_first_name', with: 'Jake'
    fill_in 'user_last_name', with: 'Smith'
    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("You're in!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'valid and required information is not provided' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match entry' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'somethingDifferent'

    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

end
