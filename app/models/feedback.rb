class Feedback < ActiveRecord::Base

  # Validate uniqueness
  validates_presence_of :name, :message
  
end
