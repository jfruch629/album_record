require 'spec_helper'
require 'rails_helper'

feature 'admin views reviews', %Q{
  As an admin,
  I would like to view all reviews,
  So I can see what material is on the website
 } do

  scenario 'user with admin role views all reviews' do
    user = FactoryBot.create(:user, admin: false)
    album = FactoryBot.create(:album, user: user)
    admin = FactoryBot.create(:user, admin: true)
    reviews = FactoryBot.create_list(:review, 10, album: album, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'


    expect(page).to have_content('(signed in as Admin)')
    click_link 'Albums'

    expect(page).to have_content("Albums")
    expect(page).to have_content("Users")
    click_link album.title

    expect(page).to have_content(reviews[1].body)
    expect(page).to have_content(reviews[2].body)
    expect(page).to have_content(reviews[3].body)
    expect(page).to have_content(reviews[4].body)

    expect(page).to have_content(reviews[0].album.title)
    expect(page).to have_content(reviews[0].album.artist)
    expect(page).to have_content(reviews[0].album.release_year)
    expect(page).to have_link('Delete')
  end

  scenario 'user without admin role fails to navigate to reviews index' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("Hey you!")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_link("Users")
    expect(page).to_not have_link("reviews")
  end
end
