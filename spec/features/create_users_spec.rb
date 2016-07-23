require 'rails_helper.rb'

feature 'Creating a new user' do

  background do
    account = create(:account)
    sign_in_with account
  end
  
  scenario 'can create a new user via the index page' do
    click_link 'Users'
    click_link 'New User'
    fill_in 'user_name', with: 'foo bar'
    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_message', with: 'Lorem Ipsum.'
    click_button 'Create User'
    expect(page).to have_content('User created!')
  end
  
  scenario "can't create a user without signing in" do
    click_link 'Logout'
    visit 'users'
    expect(page).to_not have_link('Create User')
    expect(page).to have_content('You need to sign in or sign up before 
                                  continuing.')
  end
  
  scenario "name can't be blank" do
    visit 'users/new'
    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_name', with: ''
    fill_in 'user_message', with: 'Lorem Ipsum'
    click_button 'Create User'
    expect(page).to have_content("can't be blank")
  end
  
  scenario "email can't be blank" do
    visit 'users/new'
    fill_in 'user_name', with: 'foo bar'
    fill_in 'user_email', with: ''
    fill_in 'user_message', with: 'Lorem Ipsum.'
    click_button 'Create User'
    expect(page).to have_content("Email can't be blank")
  end
  
  scenario "user email must be valid" do
    visit 'users/new'
    fill_in 'user_name', with: 'foo bar'
    fill_in 'user_email', with: 'foo@bar'
    fill_in 'user_message', with: 'Lorem Ipsum.'
    click_button 'Create User'
    expect(page).to have_content("Email is invalid")
  end

end 