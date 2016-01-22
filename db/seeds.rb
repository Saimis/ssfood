# Reset sequences
%w(users restaurants orders order_users).each do |table_name|
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end

ActiveRecord::Base.transaction do
  _admin_user = User.create!(
    email: 'admin@example.com',
    username: 'admin',
    first_name: 'admin',
    last_name: 'admin',
    password: 'test'
  )

  users = 10.times.map do |i|
    name = Faker::Name.first_name
    User.create!(
      username: name,
      email: Faker::Internet.safe_email("#{name}#{i}"),
      first_name: name,
      last_name: Faker::Name.last_name,
      password: 'test'
    )
  end

  restaurants = 10.times.map do
    Restaurant.create!(
      name: Faker::Company.name,
      website: Faker::Internet.url,
      phone: Faker::PhoneNumber.cell_phone
    )
  end

  orders = 30.times.map do
    date = Faker::Time.backward

    Order.create!(
      date: date,
      food_datetime: date + 45.minutes,
      restaurant: restaurants.sample,
      complete: 1,
      caller: users.sample,
      payer: users.sample,
      garbage_collector: users.sample
    )
  end

  orders.each do |order|
    users.each do |user|
      order.users.create!(
        order: order,
        user: user,
        restaurant: restaurants.sample,
        food: Faker::Lorem.word.camelize,
        sum: Random.rand(10.0))
    end
  end
end
