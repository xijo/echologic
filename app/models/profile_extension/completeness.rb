module ProfileExtension::Completeness
  def self.included(base)
    base.class_eval do 
      # this hash defines a list of profile fields we want the user to fill out
      # we use it when calculating the profiles completeness (after_save :calculate_completeness)
      # key => the columns name to check if it is filled
      # value => the minimum count of chars (size) to accept it as beeing filled
      @@fillable_fields = {:about_me => 20, :city => 2, :country => 2 , :first_name => 2 , :last_name => 2, :motivation => 20, :gender => 1}
      cattr_reader :fillable_fields
    end
    
    base.instance_eval do
      before_save :calculate_completeness
      
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    # we want to store a percent value of the profiles completenetss. therefore we run a method calculating it each time the profile is modified
    def calculate_completeness
      # we use floats, so we can add fields which seem uncomplete with a lower value
      fields_filled = 0.0 
       self.class.fillable_fields.each do |k,v| 
        # evalute the field, and rescue if an error occurs (e.g. it doesn't exist)
        begin         
          field = self.send(k)
        rescue
          #TODO: Log!
          next
        end
        # if the field is empty, we don't count it at all. if it is at least as full as expected we count it as filled, if it is less filled we count it accordingly less
        unless field.empty?
          field.size >= v ? fields_filled += 1.0 : fields_filled += field.size.to_f / v.to_f
        end
      end
      # save completeness into the database
      self.completeness = (fields_filled/self.class.fillable_fields.size.to_f).inspect
    end
    
  end
end
