Account.create!(email: "user@example.com",
                password: "password", 
                password_confirmation: "password",
                confirmed_at: Time.now,
                id: 1)
                
10.times do |y|
  User.create!(
    name: Faker::GameOfThrones.character,
    email: Faker::Internet.safe_email("user#{y+1}"),
    message: Faker::StarWars.quote,
    account_id: 1,
    id: y+1)
end

100.times do |n|
  Bill.create!(
    amount: Faker::Number.decimal(3,2),
    total_data: Faker::Number.decimal(2,3),
    data_cost: Faker::Number.decimal(2,2),
    date: Faker::Date.between(1.year.ago, Date.today),
    id: n+1,
    account_id: 1)
  10.times do |x|
    Charge.create!(
      user_id: x+1,
      bill_id: n+1,
      account_id: 1,
      surcharges: Faker::Number.decimal(2,2),
      data_used: Faker::Number.decimal(1,3),
      paid: Faker::Boolean.boolean,
    )
  end
end

