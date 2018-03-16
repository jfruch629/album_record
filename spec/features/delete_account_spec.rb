require 'spec_helper'
 require 'rails_helper'

 feature 'user deletes account', %Q{
   As an authenticated user,
   I want to delete my account,
   So that my information is no longer retained by the app
  } do

   # ACCEPTANCE CRITERIA:
   # •	I must be signed in to delete account
   # •	If deleted, user must be signed out, credentials cleared, and redirected to home page
   # • User should not be able to sign in once deleting account

   scenario 'user successfully deletes account' do
     user = FactoryBot.create(:user)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'

     expect(page).to have_content("Hey you!")
     expect(page).to have_content("Sign Out")

     click_link 'Edit Profile'
     click_button 'Cancel my account'

     expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
     expect(page).to have_content('Sign Up')
     expect(page).to_not have_content('Edit Profile')
   end

   scenario 'user attempts to login after deleting account' do
     user = FactoryBot.create(:user)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'

     click_link 'Edit Profile'
     click_button 'Cancel my account'

     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'

     expect(page).to have_content('Invalid Email or password.')
   end
 end
