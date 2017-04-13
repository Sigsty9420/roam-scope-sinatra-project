class Tip < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethdods
  belongs_to :city
  belongs_to :user
end
