require 'spec_helper'
require 'rails_helper'

 feature 'user reads reviews associated to album', %Q{
   As an authenticated user
   I would like to view all the reviews for a given album
   So that I can see what others think of the album
  } do

    scenario 'user is able to see reviews' do
      user = FactoryBot.create(:user, admin: false)
      album = FactoryBot.create(:album, user: user)
      review = FactoryBot.create(:review, album: album, user: user)

     visit root_path
     click_link album.title

     expect(page).to have_content('Metronomy')
     expect(page).to have_content(review.body)
   end


    scenario 'authenticated user is able to see space to add new review' do
      user = FactoryBot.create(:user, admin: false)
      album = FactoryBot.create(:album, user: user)


       visit root_path
       click_link 'Sign In'
       fill_in 'Email', with: album.user.email
       fill_in 'Password', with: album.user.password
       click_button 'Sign In'

       visit root_path

       click_link album.title

       expect(page).to have_content('Submit your thoughts on this album, below:')
       expect(page).to have_button('Save Review')
     end
   end
