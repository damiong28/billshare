require 'rails_helper.rb'

feature 'Creating a new user' do

  background do
    user = create(:user)
    sign_in_with user
  end
  
  scenario 'can create a new account via the index page' do
    fill_in 'account_email', with: 'sxyrailsdev@myspace.com'
    fill_in 'account_password', with: 'supersecret', match: :first
    fill_in 'account_password_confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content('Welcome!')
  end
  
end 