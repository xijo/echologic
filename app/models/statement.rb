class Statement < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :document, :class_name => "StatementDocument"
  has_one :author, :through => :document

  belongs_to :root_statement, :foreign_key => "root_id", :class_name => "Statement"
  acts_as_tree :scope => :root_statement
  
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
  
  
  belongs_to :work_packages
  
  validates_associated :creator, :document
  
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
