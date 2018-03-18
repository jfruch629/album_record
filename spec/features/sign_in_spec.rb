require 'spec_helper'
require 'rails_helper'

feature 'user signs in', %Q{
  As an unauthenticated user,
  I want to sign in,
  So that I can post items and review them
 } do

  # ACCEPTANCE CRITERIA:
  # •	If I specify a valid, previously registered email and password, I am authenticated and I gain access to the system
  # •	If I specify an invalid email and password, I remain unauthenticated
  # •	If I am already signed in, I can't sign in again

  scenario 'an existing user specifies a valid email and password' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("Hey you!")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content('(signed in as Admin)')
  end

  scenario 'a nonexistent email and password is supplied is denied access' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to_not have_content('Hey you!')
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'a existing with the wrong password is denied is access' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password.')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated cannot re-sign in' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_registration_path
    expect(page).to have_content('You are already signed in.')
  end
end
