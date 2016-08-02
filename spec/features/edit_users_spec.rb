require 'rails_helper.rb'

feature 'Editing a user:' do

  background do
    account = create(:account)
    sign_in_with account
    user = create(:user)
  end
  
  scenario 'can edit an user via the index page' do
    click_link 'Users'
    click_link 'testuser'
    click_link 'Edit User'
    fill_in 'user_name', with: 'testuser1'
    fill_in 'user_email', with: 'foo1@bar.com'
    fill_in 'user_message', with: 'Valar morghulis'
    click_button 'Update User'
    expect(page).to have_content('User updated!')
    expect(page).to have_content('testuser1')
    expect(page).to have_content('foo1@bar.com')
  end
  
  scenario 'can edit an user via URL' do
    visit '/users/1/edit'
    fill_in 'user_name', with: 'testuser1'
    fill_in 'user_email', with: 'foo1@bar.com'
    fill_in 'user_message', with: 'Valar morghulis'
    click_button 'Update User'
    expect(page).to have_content('User updated!')
    expect(page).to have_content('testuser1')
    expect(page).to have_content('foo1@bar.com')
  end
  
  scenario "fields can't be blank" do
    visit '/users/1/edit'
    fill_in 'user_name', with: ''
    fill_in 'user_email', with: ''
    click_button 'Update User'
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Edit User")
  end
  
  scenario "email must be valid" do
    visit '/users/1/edit'
    fill_in 'user_email', with: 'a.a.a'
    click_button 'Update User'
    expect(page).to have_content("Email is invalid")
  end
  
  scenario "restrict access to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    visit '/users/1/edit'
    expect(page).to_not have_link("Edit User Info")
    expect(page).to have_content("That user doesn't belong to you!")
  end
  
  scenario "can't edit a user without signing in" do
    click_link 'Logout'
    visit 'users/1/edit'
    expect(page).to_not have_content('Edit User')
    expect(page).to have_content('You need to sign in or sign up before 
                                  continuing.')
  end
end 