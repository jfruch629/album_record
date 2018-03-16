require 'spec_helper'
require 'rails_helper'

 feature 'deleting a review', %Q{
   As an authenticated user
   I would like to delete the review I have posted
   So that I can decide what I want to put on the site
  } do

    scenario 'authenticated user deletes their created album review' do
      album = FactoryBot.create(:album,
       user: User.create( first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
      Review.create(body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.", user: album.user, album: album )

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
      album = FactoryBot.create(:album,
       user: User.create( first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
      Review.create(body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.", user: album.user, album: album )

      visit root_path
      click_link album.title

      expect(page).to_not have_content('Delete Review')
    end

    scenario 'authenticated user attempts to delete another users review' do
      user = User.create({first_name: "John", last_name: "Smith", email: "johnsmith@example.com", password: "johnsmith"})
      album = FactoryBot.create(:album,
       user: FactoryBot.create(:user, first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
      Review.create(body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean  commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.", user: user, album: album )

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: album.user.email
      fill_in 'Password', with: album.user.password
      click_button 'Sign In'
      click_link album.title

      expect(page).to have_content('by John Smith')
      expect(page).to_not have_content('Edit Review')
      expect(page).to_not have_content('Delete Review')
      expect(page).to have_content('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ae')
    end
  end
