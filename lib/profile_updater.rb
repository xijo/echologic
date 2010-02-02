# this module ist meant to be included in all associated profile fields (e.g. concernments)
module ProfileUpdater
  def self.included(base)
    base.instance_eval do
      after_save :update_profile
      after_destroy :update_profile 
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    # updates the profile 
    def update_profile
      unless !self.user.profile
        self.user.profile.calculate_completeness
        self.user.profile.save
      end
    end
  end
end
