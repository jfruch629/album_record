require 'rails_helper'

 feature 'user updates an album', %Q{
   As an authenticated user,
   I want to update an item's information,
   So that I can correct errors or provide new information
  } do

   # ACCEPTANCE CRITERIA:
   # •	I must be signed in to update album information
   # •	I must be able to get to Edit page from the index OR show page

   scenario 'a signed in user successfully updates their album' do
     # For this & the tests below, I need to include verifying with a password
      user = FactoryBot.create(:user)
      album = FactoryBot.create(:album, user: user)
     visit root_path
     click_link 'Sign In'
     fill_in 'Email', with: user.email
     fill_in 'Password', with: user.password
     click_button 'Sign In'

     click_link album.title
     click_link 'Update'
     fill_in 'album_title', with: 'Summer 08Edited'
     fill_in 'album_artist', with: 'MetronomyEdited'
     fill_in 'album_summary', with: 'Edited Summary'
     fill_in 'album_release_year', with: '2000-never'

     click_button 'Save'

     expect(page).to have_content('Album Updated')
   end

   scenario 'a signed in user does not successfully update their album' do
     album = FactoryBot.create(:album,
      user: FactoryBot.create(:user, first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))
        visit root_path
        click_link 'Sign In'
        fill_in 'Email', with: album.user.email
        fill_in 'Password', with: album.user.password
        click_button 'Sign In'

        click_link album.title
        click_link 'Update'

        fill_in 'Title', with: ''
        fill_in 'Artist', with: ''
        fill_in 'Summary', with: ''
        fill_in 'album_release_year', with: ''
        click_button 'Save'

        expect(page).to have_content('Editing Album')
        expect(page).to have_content('4 errors prohibited this album from being saved:')
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Artist can't be blank")
        expect(page).to have_content("Summary can't be blank")
        expect(page).to have_content("Release year can't be blank")
      end

      scenario 'unauthenticated user attempts to update an album' do
        user = FactoryBot.create(:user)
        album = FactoryBot.create(:album, user: user)

        visit root_path
        click_link album.title

        expect(page).to_not have_content('Update')
      end

      scenario 'authenticated user attempts to update someone elses album' do
        user = User.create({first_name: "John", last_name: "Smith", email: "johnsmith@example.com", password: "johnsmith"})
        album = FactoryBot.create(:album,
         user: FactoryBot.create(:user, first_name: "Jill", last_name: "Scott", email: "jill@example.com", password: "password"))

        visit root_path
        click_link 'Sign In'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign In'

        click_link album.title

        expect(page).to have_content('Jill Scott (jill@example.com) uploaded this album page.')
        expect(page).to_not have_content('Update')
      end
    end
