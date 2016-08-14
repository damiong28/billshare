require 'rails_helper.rb'

feature 'Pay a charge:' do

  background do
    account = create(:account)
    sign_in_with account
    user = create(:user)
    bill = create(:bill)
    charge = create(:charge)
  end
  
  scenario "paying a charge will update user balance" do
    visit '/users'
    expect(page).to have_content("$100.00"), 'new charge not setting balance'
    visit '/bills/1'
    click_link 'unpaid'
    expect(page).to have_content("Charge updated!")
    expect(page).to have_content("$0.00")
    expect(page).to have_link('paid')
    visit '/users'
    expect(page).to_not have_content("$100.00")
    expect(page).to have_content("$0.00")
  end
  
  scenario "paying a charge will update a bill balance" do
    visit '/'
    expect(page).to have_css("#bill-balance-1", text: "$100.00")
    visit "/bills/1"
    expect(page).to have_css("#bill-balance", text: "$100.00")
    click_link "unpaid"
    expect(page).to have_link("paid")
    expect(page).to have_css("#bill-balance", text: "$0.00")
    visit '/'
    expect(page).to have_css("#bill-balance-1", text: "$0.00")
  end
end