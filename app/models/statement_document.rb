class StatementDocument < ActiveRecord::Base
  has_many :statements, :foreign_key => 'document_id'
  
  validates_presence_of :title
  validates_presence_of :text
end
