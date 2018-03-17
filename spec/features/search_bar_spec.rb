require 'spec_helper'
 require 'rails_helper'

 feature 'Search Bar', %Q{
   As an visitor/user/admin of the site,
   I want to search for an album with the search feature,
   So that I can quickly find what I want
  } do

    scenario 'visitor uses search bar to find exisitng Album' do
      album = FactoryBot.create(:album, user: FactoryBot.create(:user))
      album_2 = FactoryBot.create(:album, user: FactoryBot.create(:user))

      visit root_path

      expect(page).to have_content(album.title)
      expect(page).to have_content(album_2.title)

      fill_in 'search', with: album.title
      click_button 'Search Albums'

      expect(page).to have_link(album.title)
      expect(page).to_not have_link(album_2.title)
    end

    scenario 'visitor uses search to find non-existent Album' do
      album = FactoryBot.create(:album, user: FactoryBot.create(:user))
      album_2 = FactoryBot.create(:album, user: FactoryBot.create(:user))

      visit root_path

      expect(page).to have_content(album.title)
      expect(page).to have_content(album_2.title)

      fill_in 'search', with: 'Not An Album'
      click_button 'Search Albums'

      expect(page).to_not have_link(album.title)
      expect(page).to_not have_link(album_2.title)

      expect(page).to have_content('There is no album containing the term Not An Album.')
    end


    scenario 'Admin uses search bar to find existing User' do
      user = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      user_3 = FactoryBot.create(:user, first_name: 'April')

      admin = FactoryBot.create(:user, admin: true)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password
      click_button 'Sign In'

      click_link 'Users'

      expect(page).to have_content("Users")
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_2.email)
      expect(page).to have_content(user_3.first_name)
      expect(page).to have_content(user_3.email)

      fill_in 'search', with: user_3.first_name
      click_button 'Search Users'

      expect(page).to have_content("Users")
      expect(page).to_not have_content(user.first_name)
      expect(page).to_not have_content(user.email)
      expect(page).to_not have_content(user_2.first_name)
      expect(page).to_not have_content(user_2.email)
      expect(page).to have_content(user_3.first_name)
      expect(page).to have_content(user_3.email)
    end


    scenario 'Admin uses search bar to find non-existent User' do
    user = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:user)
    user_3 = FactoryBot.create(:user, first_name: 'April')

    admin = FactoryBot.create(:user, admin: true)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    click_link 'Users'

    expect(page).to have_content("Users")
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user_2.first_name)
    expect(page).to have_content(user_2.email)
    expect(page).to have_content(user_3.first_name)
    expect(page).to have_content(user_3.email)

    fill_in 'search', with: 'Non Existent'
    click_button 'Search Users'

    expect(page).to have_content("There is no user containing the term Non Existent")
    expect(page).to_not have_content(user.first_name)
    expect(page).to_not have_content(user.email)
    expect(page).to_not have_content(user_2.first_name)
    expect(page).to_not have_content(user_2.email)
    expect(page).to_not have_content(user_3.first_name)
    expect(page).to_not have_content(user_3.email)
  end

  scenario 'Visitor & User should not get User search bar' do
    user = FactoryBot.create(:user)

    visit root_path

    expect(page).to_not have_content('Search Users')

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to_not have_content('Search Users')
    expect(page).to_not have_content('Search Albums')

    expect(page).to_not have_link('Users')
  end
end
