require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @password = Faker::Internet.password
    @user = User.new(
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      Faker::Internet.email,
      password:   @password,
      password_confirmation: @password
      )
    @errors = @user.errors.full_messages[0]
  end

  puts 'User model tests running...'

  it 'successfully creates a valid user' do
    @user.save
    expect(@user).to be_valid
  end

  it 'fails to save user if passwords do not match' do
    @user.password = Faker::Internet.password
    @user.save
    expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
  end

  it 'fails to save user if the password field is nil' do
    @user.password = nil
    @user.save
    expect(@user.errors.full_messages[0]).to eq("Password can't be blank")
  end

  it 'fails to save user if first_name is nil' do
    @user.first_name = nil
    @user.save
    expect(@user.errors.full_messages[0]).to eq("First name can't be blank")
  end

  it 'fails to save user if last_name is nil' do
    @user.last_name = nil
    @user.save
    expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
  end

  it 'fails to save user if email is nil' do
    @user.email = nil
    @user.save
    expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
  end

  it 'does not allow duplicate user email' do
    @user.email = 'test@test.com'
    @user.save
    duplicate = User.create(
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      'test@test.com',
      password:   @password,
      password_confirmation: @password
      )
    expect(duplicate.errors.full_messages[0]).to eq("Email has already been taken")
  end

  it 'is not case-sensitive to email duplicates' do
    @user.email = 'test@test.com'
    @user.save
    duplicate = User.create(
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      'TEST@test.COM',
      password:   @password,
      password_confirmation: @password
      )
    expect(duplicate.errors.full_messages[0]).to eq("Email has already been taken")
  end
end

# tests below are functional - uses shoulda/matchers
# describe User do
#   it { is_expected.to validate_presence_of(:first_name) }
#   it { is_expected.to validate_presence_of(:last_name) }
#   it { is_expected.to validate_presence_of(:email) }
#   it { is_expected.to validate_uniqueness_of(:email) }
# end

