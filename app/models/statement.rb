class Statement < ActiveRecord::Base
  include Echoable
  
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
  
  # allow mass-assignment of document data.
  # FIXME: there has to be some more convenient way of doing this...
  def document=(obj)
    obj.kind_of?(Hash) ? create_document(obj) : super
  end
  
  ##
  ## NAMED SCOPES
  ##
  
  named_scope :proposals, lambda {
    { :conditions => { :type => 'Proposal' } } }
  named_scope :improvement_proposals, lambda {
    { :conditions => { :type => 'ImprovementProposals' } } }
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
  validates_presence_of :creator
  validates_associated :document
  validates_presence_of :document
  
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
     # except of questions, all statements need a valid parent
     # Todo: in future this should be mapped in a better way, e.g. pseudo:
     # * question.allowed_parents => Question, nil
     # * proposal.allowed_parents => Question
     # * improvementproposal.allowed_parents => Proposal
     # * ...
     errors.add("Parent of #{self.class.name} must be of one of #{@@valid_parents.inspect}") unless defined?(@@valid_parents) and @@valid_parents.select { |k| parent.instance_of?(k.to_s.constantize) }.any?
  end
  
  def self.display_name
    self.name.underscore.gsub(/_/,' ').capitalize
  end
  
  def title
    self.document.title
  end
  
  def text
    self.document.text
  end
  
  def level
    # simple hack to gain the level
    # problem is: as we can't use nested set (too write intensive stuff), we can't easily get the statements level in the tree
    level = 0
    level += 1 if self.parent
    level += 1 if self.root && self.root != self && self.root != self.parent
    level
  end
end
