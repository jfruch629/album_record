require "rails_helper"
require "spec_helper"

feature "photo" do
  scenario "user uploads an album photo" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Add Album'
    fill_in 'Title', with: 'Lonerism'
    fill_in 'Artist', with: 'Tame Impala'
    fill_in 'album_release_year', with: '2012'
    fill_in 'Summary', with: 'The sophomore album from Tame Impala exhibits his best work yet. It truly seems like an album meant for the 70s, while wow ing listeners with epic cruscendos and psychadelic grooves.'
    fill_in 'album_genre', with: 'psych rock'
    attach_file :album_photo, "#{Rails.root}/spec/support/images/download.jpg"

    click_button 'Save'

    expect(page).to have_css("img[src*='download.jpg']")
  end
end
