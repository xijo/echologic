class Statement < ActiveRecord::Base
  belongs_to :user
  acts_as_tree
  
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :user_id
end
