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
      find_or_create_echo if echo.nil?
      echo.visitor_count
    end
    
    def supporter_count
      find_or_create_echo if echo.nil?
      echo.supporter_count
    end
    
    def ratio
      if supporter_count == 0
        return 0
      end
      ((supporter_count.to_f / visitor_count.to_f) * 100).to_i
    end
    
    def find_or_create_echo
      if echo_id
        echo
      else
        echo = create_echo
        save!
        echo
      end
    end
  end
end
