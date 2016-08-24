require 'rails_helper.rb'

feature 'Registering a new account' do

  background do
    visit '/'
    click_link 'Register'
  end
  
  scenario 'can create a new account via the index page' do
    fill_in 'account_email', with: 'sxyrailsdev@myspace.com'
    fill_in 'account_password', with: 'supersecret', match: :first
    fill_in 'account_password_confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  
end 