class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethdods
  has_many :tips
  has_secure_password
end
