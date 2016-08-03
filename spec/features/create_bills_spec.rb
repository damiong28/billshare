require 'rails_helper.rb'

feature 'Creating a new bill:' do

  background do
    account = create(:account)
    sign_in_with account
  end
  
  scenario 'can create a new bill via the index page' do
    click_link 'New Bill'
    fill_in 'bill_bill_amount', with: '200'
    fill_in 'bill_total_data', with: '10'
    fill_in 'bill_data_cost', with: '40'
    click_button 'Start Bill'
    expect(page).to have_content('Edit Bill Header')
  end
  
  scenario "must sign in to create bill" do
    click_link "Logout"
    visit '/'
    expect(page).to_not have_content('New Bill')
    visit '/bills/new'
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
  
  scenario "bill fields required" do
    click_link 'New Bill'
    click_button 'Start Bill'
    expect(page).to have_content("Data cost can't be blank")
    expect(page).to have_content("Total data can't be blank")
    expect(page).to have_content("Bill amount can't be blank")
  end
  
  scenario "amounts can't be negative" do
    click_link 'New Bill'
    fill_in 'bill_bill_amount', with: '-200'
    fill_in 'bill_total_data', with: '-10'
    fill_in 'bill_data_cost', with: '-40'
    click_button 'Start Bill'
    expect(page).to have_content("Bill amount must be greater than or equal to 0")
    expect(page).to have_content("Total data must be greater than or equal to 0")
    expect(page).to have_content("Data cost must be greater than or equal to 0")
  end
  
   scenario "restrict access to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    create(:bill)
    click_link 'Logout'
    sign_in_with other_account
    visit '/'
    expect(page).to_not have_content("100.00")
    visit '/bills/1'
    expect(page).to have_content("That bill doesn't belong to you!")
    expect(page).to_not have_content("Edit Bill Header")
  end
end 