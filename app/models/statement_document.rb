class StatementDocument < ActiveRecord::Base
  has_many :statements
  
  validates_presence_of :title
  validates_presence_of :text
end
