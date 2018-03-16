require 'spec_helper'
require 'rails_helper'

feature 'admin views users', %Q{
  As an admin,
  I would like to view all users,
  So I can see who is authenticated on the website
 } do

  scenario 'user with admin role views all users' do
    users = FactoryBot.create_list(:user, 10)
    admin = FactoryBot.create(:user, admin: true)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_content("Hey you!")
    expect(page).to have_content("Sign Out")
    expect(page).to have_content("Users")

    click_link 'Users'

    expect(page).to have_content("Users")
    expect(page).to have_content(users[0].first_name)
    expect(page).to have_content(users[0].email)
    expect(page).to have_content(users[5].email)
    expect(page).to have_content(users[6].last_name)

    click_link users[0].email

    expect(page).to have_content(users[0].email)
    expect(page).to have_content(users[0].first_name)
    expect(page).to have_content(users[0].last_name)
    expect(page).to have_link('Delete')
    expect(page).to have_link('Update')
  end

  scenario 'user without admin role fails to navigate to users index' do
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
