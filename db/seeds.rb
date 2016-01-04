100.times do |n|
  name = Faker::Name.name
  email = "example-#{n}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
