FactoryGirl.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
  end

  factory :invalid_user do
    last_name     { Faker::Name.last_name }
  end
end