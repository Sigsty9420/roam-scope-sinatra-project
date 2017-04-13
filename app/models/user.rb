class User < ActiveRecord::Base
  has_many :tips
  has_secure_password
end
