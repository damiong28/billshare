require 'rails_helper.rb'

feature 'Editing a bill:' do

  background do
    account = create(:account)
    sign_in_with account
    bill = create(:bill)
    visit '/'
  end
  
  scenario 'can edit a bill via the index page' do
    find_link("bill-1").click
    click_link ('Edit Bill Header')
    fill_in 'bill_bill_amount', with: '200'
    fill_in 'bill_total_data', with: '10'
    fill_in 'bill_data_cost', with: '40'
    click_button 'Update Bill'
    expect(page).to have_content("Bill updated!")
    expect(page).to have_content("$200.00")
    expect(page).to have_content("10.0 GB")
    expect(page).to have_content("$40.00")
  end
  
  scenario "must sign in to edit bill" do
    click_link "Logout"
    visit '/'
    expect(page).to_not have_content('$100.00')
    visit '/bills/1/edit'
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
  
  scenario "bill fields required" do
    visit '/bills/1/edit'
    fill_in 'bill_bill_amount', with: ''
    fill_in 'bill_total_data', with: ''
    fill_in 'bill_data_cost', with: ''
    click_button 'Update Bill'
    expect(page).to have_content("Data cost can't be blank")
    expect(page).to have_content("Total data can't be blank")
    expect(page).to have_content("Bill amount can't be blank")
  end
  
  scenario "amounts can't be negative" do
    visit 'bills/1/edit'
    fill_in 'bill_bill_amount', with: '-200'
    fill_in 'bill_total_data', with: '-10'
    fill_in 'bill_data_cost', with: '-40'
    click_button 'Update Bill'
    expect(page).to have_content("Bill amount must be greater than or equal to 0")
    expect(page).to have_content("Total data must be greater than or equal to 0")
    expect(page).to have_content("Data cost must be greater than or equal to 0")
  end
  
   scenario "restrict access to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    visit '/'
    expect(page).to_not have_content("100.00")
    visit '/bills/1/edit'
    expect(page).to have_content("That bill doesn't belong to you!")
    expect(page).to_not have_content("Update Bill")
  end
end 