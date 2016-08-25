require 'rails_helper.rb'

feature 'Deleting a charge:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:bill)
    create(:user)
    create(:charge)
    visit '/'
  end
  
  scenario 'can delete a charge via the index page' do
    click_link 'bill-1'
    click_link 'edit-charge-1'
    click_link 'Delete Charge'
    expect(page).to have_content("Charge deleted!")
    expect(page).to_not have_content('$50.00')
    expect(page).to_not have_content('5.0 GB')
  end
  
  scenario "must sign in to delete charge" do
    click_link "Logout"
    visit '/bills/1/charges/1/edit'
    expect(page).to_not have_content('Delete Charge')
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
  
  scenario "restrict navigation to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    visit '/'
    expect(page).to_not have_content("100.00")
    visit '/bills/1/charges/1/edit'
    expect(page).to have_content("That charge doesn't belong to you!")
    expect(page).to_not have_content("Delete Bill")
  end
  
  scenario "users can't delete other's posts by http" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    page.driver.submit :delete, "/bills/1/charges/1", {}
    expect(page).to_not have_content("Charge deleted!")
    expect(page).to have_content("That charge doesn't belong to you!")
  end
  
  scenario "User and Bill balance is updated when charge is deleted" do
    visit '/bills/1/charges/1/edit'
    click_link 'Delete Charge'
    expect(page).to have_content('Charge deleted!')
    visit '/bills/1'
    expect(find('#bill-balance')).to have_content("$100.00")
    expect(page).to_not have_content("$50.00")
    visit '/users/1'
    expect(page).to_not have_content("$50.00")
    visit '/users'
    expect(page).to_not have_content("$50.00")
  end
  
end 