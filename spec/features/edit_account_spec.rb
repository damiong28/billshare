require 'rails_helper.rb'

feature 'Editing an account' do

  background do
    
  end
  
  scenario 'can edit an account' do
    user = create(:account)
    sign_in_with user
    visit '/accounts/edit'
    fill_in 'account_email', with: 'foo@example.com'
    fill_in 'account_password', with: 'supersecret', match: :first
    fill_in 'account_password_confirmation', with: 'supersecret'
    fill_in 'account_current_password', with: 'password'
    click_button 'Update Account'
    expect(page).to have_content('You updated your account successfully')
  end
  
end 