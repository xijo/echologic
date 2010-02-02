class Membership < ActiveRecord::Base
  belongs_to :user
  
  # module to update the profile (e.g. completeness) after_save, after_destroy
  include ProfileUpdater
  
  validates_presence_of :organisation, :position, :user_id
  
end
