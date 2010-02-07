# this module is meant to be included in models/profile.rb
module ProfileExtension::Completeness
  def self.included(base)
    base.class_eval do 
      # this hash defines a list of profile fields we want the user to fill out
      # we use it when calculating the profiles completeness (after_save :calculate_completeness)
      # key => the columns name to check if it is filled
      # value => the minimum count of chars (size) to accept it as beeing filled
      @@fillable_fields = [:about_me, :city, :country, :first_name, :last_name, :motivation, [:concernments,:affected], [:concernments, :engaged], [:concernments, :scientist], [:concernments, :representative], :memberships, :web_profiles, :avatar]
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
       self.class.fillable_fields.each do |f| 
        # evalute the field, and rescue if an error occurs (e.g. it doesn't exist)   
         if f.kind_of?(Array)
           field = self.send(f[0]).send(f[1])
         else
          field = self.send(f)
         end
        # if the field is not empty we count it
        # TODO: consider verifying that it's not only one letter
        if f == :avatar
          # TODO: this will break, once the default_*_avatar url changes
          fields_filled += 1.0 unless field.url.match(/images\/default_.+_avatar\.png/)
        else
          fields_filled += 1.0 unless field.nil? || field.empty?
        end
      end
      # save completeness into the database
      self.completeness = (fields_filled/self.class.fillable_fields.size.to_f)
    end
    
    # lets make the float a proper percent value
    def percent_completed
      (self.completeness*100).round
    end
  end
end
