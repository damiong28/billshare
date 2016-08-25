require 'rails_helper.rb'

feature 'Pay a charge:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:user)
    create(:bill)
    create(:charge)
  end
  
  scenario "paying a charge will update user balance" do
    visit '/users'
    expect(page).to have_content("$50.00"), 'new charge not setting balance'
    visit '/bills/1'
    expect(find('#bill-balance')).to have_content("$100.00"), 'bill balance not decreasing'
    click_link 'unpaid'
    expect(page).to have_content("Charge updated!")
    expect(find('#bill-balance')).to have_content("$50.00"), 'bill balance not decreasing'
    expect(page).to have_link('paid')
    visit '/users'
    expect(page).to_not have_content("$50.00"), "user balance not decreasing"
    expect(page).to have_content("$0.00")
  end
  
  scenario "paying a charge will update a bill balance" do
    visit '/'
    expect(page).to have_css("#bill-balance-1", text: "$100.00")
    visit "/bills/1"
    expect(page).to have_css("#bill-balance", text: "$100.00")
    click_link "unpaid"
    expect(page).to have_link("paid")
    expect(page).to have_css("#bill-balance", text: "$50.00")
    visit '/'
    expect(page).to have_css("#bill-balance-1", text: "$50.00")
  end
end