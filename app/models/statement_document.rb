class StatementDocument < ActiveRecord::Base
  has_many :statements, :foreign_key => 'document_id'
  belongs_to :author, :class_name => "User"
  
  validates_presence_of :title
  validates_presence_of :text
  validates_associated :author
  validates_presence_of :author
end
