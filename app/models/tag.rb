class Tag < ActiveRecord::Base
  has_many :concernments
  has_many :users, :through => :concernments

  validates_presence_of :value
end
