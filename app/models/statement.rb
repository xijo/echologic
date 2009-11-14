class Statement < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, :foreign_key => 'document_id', :class_name => "StatementDocument"
  acts_as_tree
  
  
  validates_presence_of :user_id
  validates_presence_of :document_id
  
  private
  # takes an array of class names that are valid for the parent association.
  # the class names should either be strings or symbols, no constants. They
  # will be constantized within the instance, hence won't place a loading
  # constraint on the models (which might lead to loops in our case)
  def self.validates_parent(*klasses)
    instance_eval do
      def validate
        errors.add("Parent of #{self.class.name} must be of one of #{klasses.inspect}") unless klasses.select { |k| parent.instance_of?(k.to_s.constantize) }.any?
      end
    end
  end
end
