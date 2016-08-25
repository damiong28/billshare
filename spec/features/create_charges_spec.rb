require 'rails_helper.rb'

feature 'Creating a new charge:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:user)
    bill = create(:bill)
  end
  
  scenario 'can create a new charge via the index page' do
    visit '/'
    find(:xpath, "//a[contains(@href,'/bills/1')]").click
    click_link "Add User Charge"
    select 'testuser', from: 'charge_user_id', visible: false
    fill_in 'charge_surcharges', with: '20.01'
    fill_in 'charge_data_used', with: '2.1'
    click_button 'Create Charge'
    expect(page).to have_content('Charge added!')
    expect(page).to have_content('testuser')
    expect(page).to have_content('$20.01')
    expect(page).to have_content('2.1 GB')
    expect(page).to have_content('21.0%')
    expect(page).to have_content('$8.40')
  end
  
  scenario "must sign in to create charge" do
    click_link "Logout"
    expect(page).to have_content("Signed out successfully")
    visit '/bills/1'
    expect(page).to_not have_content('Bill Creator')
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    visit '/bills/1/charges/new'
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(page).to_not have_content("Create Charge")
  end
  
  scenario "charge fields required" do
    visit '/bills/1/charges/new'
    click_button 'Create Charge'
    expect(page).to have_content("User can't be blank")
    expect(page).to have_content("Surcharges can't be blank")
    expect(page).to have_content("Data used can't be blank")
  end
  
  scenario "amounts can't be negative" do
    visit '/bills/1/charges/new'
    select 'testuser', from: 'charge_user_id'
    fill_in 'charge_surcharges', with: '-20.01'
    fill_in 'charge_data_used', with: '-2.1'
    click_button 'Create Charge'
    expect(page).to have_content("Surcharges must be greater than or equal to 0")
    expect(page).to have_content("Data used must be greater than or equal to 0")
  end
  
  scenario "amounts can't overflow data constraints" do
    visit '/bills/1/charges/new'
    select 'testuser', from: 'charge_user_id'
    fill_in 'charge_surcharges', with: '10000'
    fill_in 'charge_data_used', with: '10000'
    click_button 'Create Charge'
    expect(page).to have_content("Surcharges must be less than 10000")
    expect(page).to have_content("Data used must be less than 1000")
  end
  
  scenario "restrict access to account owner" do
    other_account = create(:account, email: "bar@foo.com", id: 2)
    create(:charge)
    click_link 'Logout'
    sign_in_with other_account
    visit '/'
    expect(page).to_not have_content("100.00")
    visit '/bills/1/charges/1/edit'
    expect(page).to have_content("That charge doesn't belong to you!")
    expect(page).to_not have_content("Update Charge")
  end
  
  scenario "creating a charge will update bill totals" do
    visit '/bills/1'
    expect(find('#data-subtotal')).to have_content("0.0 GB")
    expect(find('#percent-total')).to have_content("0.0%")
    expect(find('#data-share-total')).to have_content("$0.00")
    expect(find("#surcharges-total")).to have_content("$0.00")
    expect(find("#subtotal")).to have_content("$0.00")
    create(:charge)
    visit '/bills/1'
    expect(find('#data-subtotal')).to have_content("5.0 GB")
    expect(find('#percent-total')).to have_content("50.0%")
    expect(find('#data-share-total')).to have_content("$20.00")
    expect(find("#surcharges-total")).to have_content("$30.00")
    expect(find("#subtotal")).to have_content("$50.00")
  end
end 