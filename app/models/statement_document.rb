class StatementDocument < ActiveRecord::Base

  belongs_to :author, :class_name => "User"
  belongs_to :statement
  
  validates_presence_of :title
  validates_presence_of :text
  validates_associated :author
  validates_presence_of :author
end
