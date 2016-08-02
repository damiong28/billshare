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
    click_button 'Delete Bill'
    expect(page).to have_content('Bill Deleted!')
    expect(page).to_not have_content('$100.00')
    expect(page).to_not have_content('$40.00')
    expect(page).to_not have_content('10.0 GB')
    expect(page).to_not have_content('0.0 GB')
    expect(page).to have_content("You haven't created any bills yet!")
  end
end 