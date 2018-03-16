require 'spec_helper'
require 'rails_helper'

feature 'admin deletes user', %Q{
  As an admin,
  I would like to delete a user,
  So that they are not authenticated anymore
 } do

   scenario 'admin deletes user' do
   users = FactoryBot.create_list(:user, 10)
   admin = FactoryBot.create(:user, admin: true)
   visit root_path
   click_link 'Sign In'
   fill_in 'Email', with: admin.email
   fill_in 'Password', with: admin.password
   click_button 'Sign In'
   click_link 'Users'
   click_link users[0].email

   expect(page).to have_content(users[0].email)
   expect(page).to have_content(users[0].first_name)
   expect(page).to have_content(users[0].last_name)

   click_link 'Delete'
   expect(page).to have_content("User successfully removed.")
   expect(page).to have_content("Users")
   expect(page).to_not have_content("Sign In")

   expect(page).to_not have_content(users[0].email)
 end
end
