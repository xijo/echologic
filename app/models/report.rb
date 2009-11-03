class Report < ActiveRecord::Base

  belongs_to :suspect,  :class_name => 'User', :foreign_key => 'suspect_id'
  belongs_to :reporter, :class_name => 'User', :foreign_key => 'reporter_id'

  validates_presence_of :reason, :suspect_id, :reporter_id

  # TODO helpful but not working yet.
  self.named_scope :active, :conditions => { :done => false }
  self.named_scope :done,   :conditions => { :done => true }

end
