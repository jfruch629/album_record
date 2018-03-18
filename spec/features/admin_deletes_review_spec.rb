require 'spec_helper'
require 'rails_helper'

feature 'admin deletes review', %Q{
  As an admin,
  I would like to delete a review,
  So that the review is no longer visible
 } do

   scenario 'admin deletes review' do
     user = FactoryBot.create(:user, admin: false)
     albums = FactoryBot.create_list(:album, 9, user: user)
     review = FactoryBot.create(:review, album: albums[0], user: user)
     admin = FactoryBot.create(:user, admin: true)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: admin.email
     fill_in 'Password', with: admin.password
     click_button 'Sign In'
     expect(page).to have_content("Users")
     expect(page).to have_content('(signed in as Admin)')

     click_link 'Albums'
     click_link albums[0].title

     expect(page).to have_content(albums[0].title)
     expect(page).to have_content(albums[0].artist)
     expect(page).to have_content(albums[0].release_year)
     expect(page).to have_content(albums[0].reviews[0].body)

     click_link 'Delete Review'

     expect(page).to have_content("Review successfully removed.")
     expect(page).to have_content(albums[0].title)
     expect(page).to have_content(albums[0].artist)
     expect(page).to_not have_content("Sign In")
   end
 end
