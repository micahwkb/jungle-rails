class User < ActiveRecord::Base

  has_secure_password

  attr_reader :first_name
end
