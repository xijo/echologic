class Tag < ActiveRecord::Base
  has_many :concernments
  has_many :users, :through => :concernments
  has_many :statements, :foreign_key => 'category_id'

  validates_presence_of :value
end
