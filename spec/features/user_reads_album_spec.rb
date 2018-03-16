require 'spec_helper'
require 'rails_helper'

feature 'user views all albums', %Q{
  As an authenticated user,
  I want to view a list of items,
  So that I can pick items to review
 } do

  # ACCEPTANCE CRITERIA:
  # •	I must be able get all albums from the index page
  # •	I do not need to be signed in to view all albums
  # •	Each album listing should contain an album name, artist, & year

  scenario 'user views all albums' do
    visit root_path

    expect(page).to have_content('All Albums')
    expect(page).to have_content('Sign In')
  end

  scenario 'user views an album' do
   user = FactoryBot.create(:user)
    album = FactoryBot.create(:album, user: user)
    visit root_path
    click_link album.title

    expect(page).to have_content('Metronomy')
  end
end
