require 'rails_helper.rb'

feature 'Sending a bill:' do

  background do
    account = create(:account)
    sign_in_with account
    create(:bill)
    create(:user)
    create(:charge)
    clear_emails
  end
  
  scenario 'can send a bill to one user' do
    visit '/bills/1/send'
    open_email('foo@bar.com')
    expect(current_email).to have_content('Hi there, testuser!')
    expect(current_email).to have_content('August')
    expect(current_email).to have_content('$100.0')
    expect(current_email).to have_content('10.0 GB')
    expect(current_email).to have_content('5.0 GB')
    expect(current_email).to have_content('$40.00')
    expect(current_email).to have_content('$30.00')
    expect(current_email).to have_content('$50.00')
    expect(current_email).to have_content('Test message.')
  end
  
  scenario 'can send a bill to multiple users' do
    create(:user, name: "Rob Stark", email: "king@thenorth.com", 
      message: "Winter is coming.", id: 2)
    create(:charge, user_id: 2, id: 2)
    visit '/bills/1/send'
    open_email("king@thenorth.com")
    expect(current_email).to have_content('Hi there, Rob Stark!')
    expect(current_email).to have_content('$50.00')
    expect(current_email).to have_content('5.0 GB')
    expect(current_email).to have_content('Winter is coming.')
    open_email("foo@bar.com")
    expect(current_email).to have_content('Hi there, testuser!')
    expect(current_email).to have_content('August')
    expect(current_email).to have_content('Test message.')
    expect(current_email).to have_content('$100.0')
  end
end