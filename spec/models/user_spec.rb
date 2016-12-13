require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @password = Faker::Internet.password(8)
    @user = User.new(
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      Faker::Internet.email,
      password:              @password,
      password_confirmation: @password
      )
    @errors = @user.errors.full_messages.first
  end

  describe 'Validations' do
    puts 'User model tests running...'

    it 'successfully creates a valid user' do
      @user.save
      expect(@user).to be_valid
    end

    it 'fails to save user if passwords do not match' do
      @user.password = Faker::Internet.password
      @user.save
      expect(@user.errors.full_messages.first).to eq("Password confirmation doesn't match Password")
    end

    it 'fails to save user if the password field is nil' do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages.first).to eq("Password can't be blank")
    end

    it 'fails to save user if first_name is nil' do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages.first).to eq("First name can't be blank")
    end

    it 'fails to save user if last_name is nil' do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages.first).to eq("Last name can't be blank")
    end

    it 'fails to save user if email is nil' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages.first).to eq("Email can't be blank")
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
      expect(duplicate.errors.full_messages.first).to eq("Email has already been taken")
    end

    it 'does not allow creation with existing email using mixed-case' do
      @user.email     = 'testing@test.com'
      @user.save
      expect(@user).to be_persisted

      duplicate_user  = User.create(
        first_name: Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email:      'TESTing@test.COM',
        password:   'password',
        password_confirmation: 'password'
        )
      expect(duplicate_user).to be_invalid
    end

    it 'requires passwords that are 8+ characters' do
      @user.password              = '123'
      @user.password_confirmation = '123'
      @user.save
      expect(@user.errors.full_messages.first).to eq("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    before(:each) do
      @password = Faker::Internet.password(8)
      @user = User.create(
        first_name: Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email:      Faker::Internet.email,
        password:              @password,
        password_confirmation: @password
        )
      @errors = @user.errors.full_messages.first
    end

    puts 'User authentication tests running...'

    it 'succeeds with valid credentials' do
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it 'succeeds with valid credentials, in mixed case' do
      user = User.create(
              first_name: Faker::Name.first_name,
              last_name:  Faker::Name.last_name,
              email:      'tester@testy.com',
              password:              'password',
              password_confirmation: 'password'
              )
      expect(User.authenticate_with_credentials('TesTer@Testy.coM', 'password')).to eq(user)
    end

    it 'succeeds with valid credentials if email prefaced by spaces' do
      expect(User.authenticate_with_credentials("   #{@user.email}", @user.password)).to eq(@user)
    end
    it 'succeeds with valid credentials if email followed by spaces' do
      expect(User.authenticate_with_credentials("#{@user.email}   ", @user.password)).to eq(@user)
    end

    it 'fails with invalid password' do
      expect(User.authenticate_with_credentials(@user.email, 'password')).to eq(false)
    end

    it 'fails with invalid email' do
      expect(User.authenticate_with_credentials('email@email.com', @user.password)).to eq(nil)
    end
  end
end