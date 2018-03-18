require 'spec_helper'
require 'rails_helper'

 feature 'deleting a review', %Q{
   As an authenticated user
   I would like to delete the review I have posted
   So that I can decide what I want to put on the site
  } do

    scenario 'authenticated user deletes their created album review' do
      user = FactoryBot.create(:user, admin: false)
      album = FactoryBot.create(:album, user: user)
      review = FactoryBot.create(:review, album: album, user: user)

       visit root_path
       click_link 'Sign In'
       fill_in 'Email', with: album.user.email
       fill_in 'Password', with: album.user.password
       click_button 'Sign In'
       click_link album.title

       click_link 'Delete Review'

       expect(page).to have_content("Review successfully removed.")
       expect(page).to_not have_content('Lorem ipsum dolor sit amet, consectetuer adipisc')
       expect(page).to have_content(album.title)
       expect(page).to have_content('Sign Out')
     end

    scenario 'unauthenticated user fails to delete a review they created while signed in' do
      user = FactoryBot.create(:user, admin: false)
      album = FactoryBot.create(:album, user: user)
      review = FactoryBot.create(:review, album: album, user: user)

      visit root_path
      click_link album.title

      expect(page).to_not have_content('Delete Review')
    end

    scenario 'authenticated user attempts to delete another users review' do
      user = FactoryBot.create(:user, admin: false)
      user_2 = FactoryBot.create(:user, admin: false)
      album = FactoryBot.create(:album, user: user)
      review = FactoryBot.create(:review, album: album, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user_2.email
      fill_in 'Password', with: user_2.password
      click_button 'Sign In'
      click_link album.title

      expect(page).to have_content(review.user.first_name)
      expect(page).to_not have_content('Edit Review')
      expect(page).to_not have_content('Delete Review')
      expect(page).to have_content('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ae')
    end
  end
