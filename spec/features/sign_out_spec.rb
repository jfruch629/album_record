require 'spec_helper'
require 'rails_helper'

feature 'user signs out', %Q{
  As an authenticated user,
  I want to sign out,
  So that no one else can post items or reviews on my behalf
 } do

  # ACCEPTANCE CRITERIA:
  # •	If I click Sign Out, I must be signed out
  # • If I am not signed in, I cannot sign out

  scenario 'signed in user successfully signs out' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit root_path

    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end
end
