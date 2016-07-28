FactoryGirl.define do
  
  factory :charge do
    surcharges 50.00
    data_used 40.00
    account_id 1
    bill_id 1
    user_id 1
    id 1
  end
  
end