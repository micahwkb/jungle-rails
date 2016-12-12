FactoryGirl.define do
  factory :product do
    name     { Faker::Commerce.product_name }
    price    { Faker::Number.number(4) }
    quantity { Faker::Number.number(2) }
    category { Faker::Internet.password }
  end
end