class Statement < ActiveRecord::Base
  belongs_to :user
  belongs_to :statement_document, :foreign_key => 'document_id'
  acts_as_tree
  
  validates_presence_of :user_id
  validates_presence_of :document_id
end
