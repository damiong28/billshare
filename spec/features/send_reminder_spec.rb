require 'rails_helper.rb'

feature 'Sending a reminder:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:bill)
    create(:user)
    create(:charge)
    create(:charge, id: 2)
    clear_emails
  end
  
  scenario 'can send a reminder to an unpaid user' do
    visit '/users/1'
    expect(page).to have_content('Send Reminder')
    visit '/users/1/send'
    open_email('foo@bar.com')
    expect(current_email).to have_content('Hi there, testuser!')
    expect(current_email).to have_content('reminder that you have an open balance of $100')
    expect(current_email).to have_content('Aug 2016')
    expect(current_email).to have_content('5.0 GB')
    expect(current_email).to have_content('$50.00')
    expect(current_email).to have_content('Test message.')
  end
end