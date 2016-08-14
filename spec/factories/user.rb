FactoryGirl.define do
  
  factory :user do
    name "testuser"
    email "foo@bar.com"
    message "Test message."
    id 1
    account_id 1
    balance 0.00
  end
  
end