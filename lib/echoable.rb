module Echoable
  def self.included(base)
    base.instance_eval do
      belongs_to :echo
      has_many :echo_details, :foreign_key => 'echo_id', :primary_key => 'echo_id'
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    def visitor_count
      echo.visitor_count
    end
    
    def support_count
      echo.support_count
    end
    
    def find_or_create_echo
      echo or create_echo
    end
  end
end
