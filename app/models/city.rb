class City < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethdods
  has_many :tips
end
