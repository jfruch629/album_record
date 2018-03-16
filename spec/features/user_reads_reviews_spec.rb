require 'spec_helper'
require 'rails_helper'

 feature 'user reads reviews associated to album', %Q{
   As an authenticated user
   I would like to view all the reviews for a given album
   So that I can see what others think of the album
  } do

    scenario 'user is able to see reviews' do
    album = FactoryBot.create(:album,
     user: User.create( first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
    Review.create(body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.", user: album.user, album: album )

     visit root_path
     click_link album.title

     expect(page).to have_content('Metronomy')
     expect(page).to have_content("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.")
   end


    scenario 'authenticated user is able to see space to add new review' do
      album = FactoryBot.create(:album,
       user: User.create( first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))

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
