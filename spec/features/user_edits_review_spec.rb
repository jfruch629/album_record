require 'spec_helper'
require 'rails_helper'

 feature 'updating a review', %Q{
   As an authenticated user,
   I would like to update the review I have posted,
   So that I can more accurately review the album
  } do

    scenario 'authenticated user successfully updates album review' do
      user = FactoryBot.create(:user)
      album = FactoryBot.create(:album, user: user)


       visit root_path
       click_link 'Sign In'
       fill_in 'Email', with: album.user.email
       fill_in 'Password', with: album.user.password
       click_button 'Sign In'
       click_link album.title

       fill_in 'review_body', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium."
       click_button 'Save Review'

       click_link 'Edit Review'

       expect(page).to have_content('Edit Review')

       fill_in 'review_body', with: "EDITED Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium."

       click_button 'Save Review'

       expect(page).to have_content('recently updated on')
       expect(page).to have_content('EDITED Lorem')
       expect(page).to_not have_content('Sign In')
     end

    scenario 'unauthenticated user attempts to update their previously created album review' do
      user = FactoryBot.create(:user)
      album = FactoryBot.create(:album, user: FactoryBot.create(:user))

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: album.user.email
      fill_in 'Password', with: album.user.password
      click_button 'Sign In'
      click_link album.title

      fill_in 'review_body', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium."
      click_button 'Save Review'

      click_link 'Sign Out'
      expect(page).to have_content('Sign In')


      click_link album.title

      expect(page).to have_content(user.first_name)
      expect(page).to_not have_content('Edit Review')
      expect(page).to have_content('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ae')

     end

    scenario "authenticated user tries to update another user's review" do
      user = User.create({first_name: "John", last_name: "Smith", email: "johnsmith@example.com", password: "johnsmith"})
      album = FactoryBot.create(:album,
       user: FactoryBot.create(:user, first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
      review = FactoryBot.create(:review, album: album, user: FactoryBot.create(:user))


      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: album.user.email
      fill_in 'Password', with: album.user.password
      click_button 'Sign In'
      click_link album.title

      expect(page).to have_content('You uploaded this album!')
      expect(page).to have_content(review.user.first_name)
      expect(page).to_not have_content('by John Smith')
      expect(page).to_not have_content('Edit Review')
      expect(page).to have_content('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ae')

    end
    scenario "authenticated unsuccesfully updates album review" do
      user = User.create(first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password")
      album = FactoryBot.create(:album, user: user)
      review = FactoryBot.create(:review, album: album, user: user)


       visit root_path
       click_link 'Sign In'
       fill_in 'Email', with: album.user.email
       fill_in 'Password', with: album.user.password
       click_button 'Sign In'
       click_link album.title

       click_link 'Edit Review'

       fill_in 'review_body', with: 'This is too short'

       click_button 'Save Review'

       expect(page).to have_content('You want to provide a strong review for a good rating, so please provide your explanation with at least 250 characters.')
       expect(page).to have_content('Edit Review')
       expect(page).to have_button('Save Review')
     end
  end
