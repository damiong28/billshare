require 'rails_helper.rb'

feature 'Edit a charge:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:user)
    create(:bill)
    create(:charge)
  end
  
  scenario 'can edit a charge via the bill show page' do
    visit 'bills/1'
    expect(page).to have_content("$100.00")
    click_link "edit-charge-1"
    select 'testuser', from: 'charge_user_id', visible: false
    fill_in 'charge_surcharges', with: '30'
    fill_in 'charge_data_used', with: '5'
    click_button 'Update Charge'
    expect(page).to have_content('Charge updated!')
    click_link 'BillShare'
    visit 'bills/1'
    expect(page).to have_content("5.0 GB")
    expect(page).to have_content("50.0%")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("$30.00")
    expect(page).to have_content("$50.00")
  end
  
  scenario "charge fields required" do
    visit '/bills/1/charges/1/edit'
    select '', from: 'charge_user_id'
    fill_in 'charge_surcharges', with: ''
    fill_in 'charge_data_used', with: ''
    click_button "Update Charge"
    expect(page).to have_content("User can't be blank")
    expect(page).to have_content("Surcharges can't be blank")
    expect(page).to have_content("Data used can't be blank")
  end
  
  scenario "amounts can't be negative" do
    visit '/bills/1/charges/1/edit'
    select 'testuser', from: 'charge_user_id'
    fill_in 'charge_surcharges', with: '-20.01'
    fill_in 'charge_data_used', with: '-2.1'
    click_button 'Update Charge'
    expect(page).to have_content("Surcharges must be greater than or equal to 0")
    expect(page).to have_content("Data used must be greater than or equal to 0")
  end
  
  scenario "restrict access to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    click_link 'Logout'
    sign_in_with other_account
    visit '/bills/1/charges/1/edit'
    expect(page).to_not have_link("Update Charge")
    expect(page).to have_content("That charge doesn't belong to you!")
  end
  
  scenario "must sign in to edit charge" do
    click_link 'Logout'
    visit '/bills/1/charges/1/edit'
    expect(page).to_not have_content('Update Charge')
    expect(page).to have_content('You need to sign in or sign up before 
                                  continuing.')
  end
  
end