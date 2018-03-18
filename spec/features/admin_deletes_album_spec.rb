require 'spec_helper'
require 'rails_helper'

feature 'admin deletes album', %Q{
 As an admin,
 I would like to delete a album,
 So that they are not authenticated anymore
} do

  scenario 'admin deletes album' do
    user = FactoryBot.create(:user, admin: false)
    albums = FactoryBot.create_list(:album, 9, user: user)
    admin = FactoryBot.create(:user, admin: true)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
    click_link 'Albums'
    click_link albums[0].title

    expect(page).to have_content('(signed in as Admin)')

    expect(page).to have_content(albums[0].title)
    expect(page).to have_content(albums[0].artist)
    expect(page).to have_content(albums[0].release_year)

    click_link 'Delete'
    expect(page).to have_content("Album successfully removed.")
    expect(page).to have_content("Albums")
    expect(page).to_not have_content("Sign In")

    expect(page).to_not have_content(albums[0].title)
    expect(page).to have_content(albums[1].title)
  end
end
