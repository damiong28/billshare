require 'rails_helper.rb'

feature 'Deleting a bill:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:bill)
    visit '/'
  end
  
  scenario 'can delete a bill via the index page' do
    click_link 'bill-1'
    click_link 'Delete Bill'
    expect(page).to have_content('Bill deleted!')
    expect(page).to_not have_content('$100.00')
    expect(page).to_not have_content('$40.00')
    expect(page).to_not have_content('10.0 GB')
    expect(page).to_not have_content('0.0 GB')
    expect(page).to have_content("You haven't created any bills yet.")
  end
  
  scenario "must sign in to delete bill" do
    click_link "Logout"
    visit '/bills/1'
    expect(page).to_not have_content('Delete Bill')
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
  
  scenario "restrict navigation to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    visit '/'
    expect(page).to_not have_content("100.00")
    visit '/bills/1'
    expect(page).to have_content("That bill doesn't belong to you!")
    expect(page).to_not have_content("Delete Bill")
  end
  
  scenario "users can't delete other's posts by http" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    page.driver.submit :delete, "/bills/1", {}
    expect(page).to_not have_content("Bill Deleted!")
    expect(page).to have_content("That bill doesn't belong to you!")
  end
  
  scenario "charges are deleted when bill is deleted" do
    create(:user)
    create(:charge)
    visit '/bills/1'
    click_link 'Delete Bill'
    expect(page).to have_content("Bill deleted!")
    visit '/users/1'
    expect(page).to_not have_content("$60.00")
    expect(page).to have_content("You haven't entered any charges for this user yet.")
  end
  
end 