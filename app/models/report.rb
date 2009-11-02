class Report < ActiveRecord::Base

  has_one :suspect,  :class_name => 'User', :foreign_key => 'suspect_id'
  has_one :reporter, :class_name => 'User', :foreign_key => 'reporter_id'
  
  validate_presence_of :reason

end
