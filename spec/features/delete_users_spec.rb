require 'rails_helper.rb'

feature 'Deleting a user:' do

  background do
    account = create(:account)
    sign_in_with account
    user = create(:user)
  end
  
  scenario 'can delete a user via the index page' do
    click_link 'Users'
    click_link 'testuser'
    click_link 'Delete User'
    expect(page).to have_content("User deleted.")
    expect(page).to_not have_content('testuser')
    expect(page).to_not have_content('foo@bar.com')
  end
  
  scenario "can't delete a user without signing in" do
    click_link 'Logout'
    visit 'users/1'
    expect(page).to_not have_link('Delete User')
    expect(page).to have_content('You need to sign in or sign up before 
                                  continuing.')
  end
  
   scenario "restrict access to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    visit '/users'
    expect(page).to_not have_content("foo@bar.com")
    visit '/users/1/edit'
    expect(page).to have_content("That user doesn't belong to you!")
    expect(page).to_not have_content("Delete User")
  end
end