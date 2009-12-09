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
      #supporters_visitors_ratio
      supporters_supporters_ratio
    end
    
    
    #ratio of entity.supporters vs. the most supported sibblings supporters)
    def supporters_supporters_ratio
      # if we have a parent we go the easy way
      if parent && parent.most_supported_child.try(:supporter_count).to_i > 0
        max_support_count = parent.most_supported_child.supporter_count;
        ((supporter_count.to_f / max_support_count.to_f) * [10*max_support_count, 100].min).to_i
      else
        0
      end
    end
    
    # ratio of supporters vs. visitors
    # currently unused (see ratio)
    def supporters_visitors_ratio
      if supporter_count == 0
        return 0
      end
      ((supporter_count.to_f / visitor_count.to_f) * 100).to_i    
    end
   
    # finds the most supported child (used by ratio of entity vs. the most supported sibbling)
    def most_supported_child
      children.by_supporters.first
    end
    
    def find_or_create_echo
      if echo_id
        echo
      else
        echo = create_echo
        #raise self.category.inspect
        save!
        echo
      end
    end
  end
end
