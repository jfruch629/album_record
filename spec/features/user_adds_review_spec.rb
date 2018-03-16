require 'spec_helper'
require 'rails_helper'

 feature 'user adds review to album', %Q{
   As an authenticated user
   I would like to add a review to an album’s page,
   So that I can share my review with others
  } do

    scenario 'authenticated user adds a review to an album' do
      user = User.create({first_name: "John", last_name: "Smith", email: "johnsmith@example.com", password: "johnsmith"})
      album = FactoryBot.create(:album,
       user: User.create( first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
       user_2 = album.user

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      click_link album.title
      fill_in 'review_body', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium."
      click_button 'Save Review'

      expect(page).to have_content('Metronomy')
      expect(page).to have_content('Edit Review / Delete Review')
      expect(page).to have_content('John Smith')
      expect(page).to have_content("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.")
      expect(page).to have_button('Save Review')
      expect(page).to_not have_content('Review failed to Save.')
    end

    scenario 'unauthenticated user fails to add a review to an album' do
      album = FactoryBot.create(:album,
        user: User.create(first_name: "Jill", last_name: "Scott", email:      "jill@example.com", password: "password"))
      visit root_path
      click_link album.title

      fill_in 'review_body', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium."
      click_button 'Save Review'

      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_content('Log in')
      expect(page).to_not have_content('Metronomy')
    end

    scenario 'authenticated user does not meet minimum char limit' do
      user = User.create({first_name: "John", last_name: "Smith", email: "johnsmith@example.com", password: "johnsmith"})
      album = FactoryBot.create(:album,
       user: User.create(first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      click_link album.title
      fill_in 'review_body', with: "Too short"
      click_button 'Save Review'

      expect(page).to have_content('You want to provide a strong review for a good rating, so please provide your explanation with at least 250 characters.')
  end
end
