require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @category = Category.create(
      name:     Faker::Commerce.product_name
      )
    @product = Product.new(
      category: @category,
      name:     Faker::Commerce.product_name,
      price:    Faker::Number.number(4),
      quantity: Faker::Number.number(2)
      )
  end

  it 'successfully saves a valid product' do
    @product.save
    expect(@product.errors.full_messages[0]).to eq(nil)
  end

  it 'fails with error if the name is nil' do
    @product.name = nil
    @product.save
    expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
  end

  it 'fails with error if the category is nil' do
    @product.category = nil
    @product.save
    expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
  end

  it 'fails with error if price is nil' do
    @product.price_cents = nil
    @product.save
    expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
  end

  it 'fails with error if quantity is nil' do
    @product.quantity = nil
    @product.save
    expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
  end

end
