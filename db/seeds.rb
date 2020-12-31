unless (Account.find(1).present?)
  Account.create!(email: "user@example.com",
                  password: "password",
                  password_confirmation: "password",
                  confirmed_at: Time.now,
                  id: 1)
end

unless User.count > 9
  10.times do |y|
    User.create!(
      name: Faker::TvShows::GameOfThrones.character,
      email: Faker::Internet.safe_email(name: "user#{y + 1}"),
      message: Faker::Movies::StarWars.quote,
      account_id: 1,
      id: y + 1)
  end
end

10.times do |n|
  Bill.create!(
    amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    total_data: Faker::Number.decimal(l_digits: 2, r_digits: 3),
    data_cost: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now),
    id: n + 1,
    account_id: 1)
  10.times do |x|
    Charge.create!(
      user_id: x + 1,
      bill_id: n + 1,
      account_id: 1,
      surcharges: Faker::Number.decimal(l_digits: 2, r_digits: 2),
      data_used: Faker::Number.decimal(l_digits: 1, r_digits: 3),
      paid: Faker::Boolean.boolean,
    )
  end
end

