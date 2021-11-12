FactoryBot.define do
  factory :user do
    name { Faker::Name.name.truncate(5) }
    email { Faker::Internet.email }
    password { 'myPass@123' }
    password_confirmation { 'myPass@123' }
  end
end
