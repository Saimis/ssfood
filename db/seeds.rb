_admin_user = User.create(name: 'admin', password: 'test')

_users = 10.times.map do
  User.create(
    name: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    password: 'test'
  )
end
_restaurants = 10.times.map do
  Restaurant.create(
    name: Faker::Company.name,
    about: Faker::Internet.url,
    phone: Faker::PhoneNumber.cell_phone
  )
end
