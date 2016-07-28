FactoryGirl.define do
  
  factory :account do
    email "foo@bar.com"
    password "password"
    password_confirmation "password"
    id 1
    confirmed_at Time.now
  end
end