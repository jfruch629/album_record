require 'spec_helper'
 require 'rails_helper'

 feature 'authenticated user adds album', %Q{
   As an authenticated user,
   I want to add an album,
   So that others can review it
  } do

   #
   # ACCEPTANCE CRITERIA:
   # •	I must be signed in to add an album for review
   # •	I must provide a title, artist, year, & summary statement
   # •	I can optionally provide title tracks & genre
   # •	(Optional – add album cover photo?)

   scenario 'signed in user successfully adds a new album' do
     user = FactoryBot.create(:user)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'

     click_link 'Add Album'
     fill_in 'album_title', with: 'Lonerism'
     fill_in 'album_artist', with: 'Tame Impala'
     fill_in 'album_release_year', with: '2012'
     fill_in 'album_summary', with: 'The sophomore album from Tame Impala exhibits his best work yet. It truly seems like an album meant for the 70s, while wow-ing listeners with epic cruscendos and psychadelic grooves.'
     fill_in 'album_genre', with: 'psych-rock'
     click_button 'Save'

     expect(page).to have_content('Sign Out')
     expect(page).to have_content('Add Album')
     expect(page).to have_content('Lonerism')
     expect(page).to_not have_content('All Albums')
   end

   scenario 'signed in user does not add all required fields for new album' do
     user = FactoryBot.create(:user)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'

     click_link 'Add Album'
     fill_in 'Title', with: 'Lonerism'
     click_button 'Save'

     expect(page).to have_content("Artist can't be blank")
     expect(page).to have_content("Summary can't be blank")
     expect(page).to have_content("Release year can't be blank")
     expect(page).to have_content('New Album')
     expect(page).to have_content("Title")
   end

   scenario 'user signs out(unauthenticated) and attempts to create album' do
     user = FactoryBot.create(:user)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'
     click_link 'Sign Out'

     expect(page).to_not have_content('Add Album')
   end
 end
