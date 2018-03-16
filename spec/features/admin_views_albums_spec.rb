require 'spec_helper'
require 'rails_helper'

feature 'admin views albums', %Q{
  As an admin,
  I would like to view all albums,
  So I can see what material is on the website
 } do

  scenario 'user with admin role views all albums' do
    user = FactoryBot.create(:user, admin: false)
    albums = FactoryBot.create_list(:album, 10, user: user)
    admin = FactoryBot.create(:user, admin: true)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_content("Hey you!")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Albums")
    expect(page).to have_content("Users")

    click_link 'Albums'

    expect(page).to have_content("Albums")
    expect(page).to have_content(albums[0].title)
    expect(page).to have_content(albums[1].title)
    expect(page).to have_content(albums[2].title)
    expect(page).to have_content(albums[3].title)

    click_link albums[0].title

    expect(page).to have_content(albums[0].title)
    expect(page).to have_content(albums[0].artist)
    expect(page).to have_content(albums[0].release_year)
    expect(page).to have_link('Delete')
  end

  scenario 'user without admin role fails to navigate to albums index' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("Hey you!")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_link("Users")
    expect(page).to_not have_link("Albums")
  end
end
