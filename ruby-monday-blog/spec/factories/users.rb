FactoryGirl.define do
  factory :user do
    email '0@example.com'
    password 'password'
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end
