# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["kaia@mintakadesign.com", "test@test.com", "kaiaolsondebug@gmail.com", "testing@testing.com"].each do |email|
  User.create(email: email,
              password: "password",
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              role: "Consultant")
end

["tester@tester.com", "hello@test.com", "world@test.com", "helloworld@test.com"].each do |email|
  User.create(email: email,
              password: "password",
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              role: "Client")
end
