User.create!(name: Faker::Name.name,
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
