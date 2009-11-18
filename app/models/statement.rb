class Statement < ActiveRecord::Base
  
  ##
  ## ASSOCIATIONS
  ##
  
  belongs_to :creator, :class_name => "User"
  belongs_to :document, :class_name => "StatementDocument"
  has_one :author, :through => :document

  belongs_to :root_statement, :foreign_key => "root_id", :class_name => "Statement"
  acts_as_tree :scope => :root_statement

  # not yet implemented
  
  #belongs_to :work_packages
  
  ##
  ## NAMED SCOPES
  ##
  
  named_scope :proposals, lambda {
    { :conditions => { :type => 'Proposal' } } }
  named_scope :improvement_proposals, lambda {
    { :conditions => { :type => 'ImmprovementProposals' } } }
  named_scope :arguments, lambda { 
    { :conditions => ['type = ? OR type = ?', 'ProArgument', 'ContraArgument'] } }
  named_scope :pro_arguments, lambda { 
    { :conditions => { :type => 'ProArgument' } } }
  named_scope :contra_arguments, lambda { 
    { :conditions => { :type => 'ContraArgument' } } }
  
  
  ##
  ## VALIDATIONS
  ##
  
  validates_associated :creator
  validates_associated :document
  
  class << self
    attr :valid_parents
    private
    # takes an array of class names that are valid for the parent association.
    # the class names should either be strings or symbols, no constants. They
    # will be constantized within the instance, hence won't place a loading
    # constraint on the models (which might lead to loops in our case)
    def validates_parent(*klasses)
      @@valid_parents ||= []
      @@valid_parents += klasses
    end
  end
  
  def validate
    errors.add("Parent of #{self.class.name} must be of one of #{klasses.inspect}") unless defined?(@@valid_parents) and @@valid_parents.select { |k| parent.instance_of?(k.to_s.constantize) }.any?
  end
end
