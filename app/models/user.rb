 class User < ActiveRecord::Base

  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    if @user = User.find_by_email(email.downcase.strip)
      @user.authenticate(password)
    end
  end
end