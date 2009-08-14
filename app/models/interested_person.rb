class InterestedPerson < ActiveRecord::Base
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :on => :create
  # email validator
  
end
