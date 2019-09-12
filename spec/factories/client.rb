FactoryBot.define do
  factory :client do
    email        { Faker::Internet.email }
    password     { Faker::Internet.password }
    phone        { Faker::PhoneNumber.cell_phone }
    fullname     { Faker::Name.name }
  end
end
