class Statement < ActiveRecord::Base
  include Echoable
  
  # magically allows Proposal.first.question? et al.
  #
  # FIXME: figure out why this sometimes doesn't work, but only in ajax requests
#  def method_missing(sym, *args)
#    sym.to_s =~ /\?$/ && ((klass = sym.to_s.chop.camelize.constantize) rescue false) ? klass == self.class : super
#  end
  
  # static for now
  
  # returns if statement is of type proposal
  def proposal?
    self.class == Proposal
  end
  
  # returns if statement is of type improvementproposal
  def improvement_proposal?
    self.class == ImprovementProposal
  end
  
  # returns if statements is of type question
  def question?
    self.class == Question
  end
  
  ##
  ## ASSOCIATIONS
  ##

  belongs_to :creator, :class_name => "User"
  belongs_to :document, :class_name => "StatementDocument"
  has_one :author, :through => :document

  belongs_to :root_statement, :foreign_key => "root_id", :class_name => "Statement"
  acts_as_tree :scope => :root_statement
  
  belongs_to :category, :class_name => "Tag"

  # not yet implemented

  #belongs_to :work_packages

  # allow mass-assignment of document data.
  # FIXME: there has to be some more convenient way of doing this...
  def document=(obj)
    obj.kind_of?(Hash) ? (document ? document.update_attributes!(obj) : create_document(obj)) : super
  end ; alias :statement_document= :document=

  ##
  ## NAMED SCOPES
  ##
    
  named_scope :proposals, lambda {
    { :conditions => { :type => 'Proposal' } } }
  named_scope :improvement_proposals, lambda {
    { :conditions => { :type => 'ImprovementProposal' } } }
  named_scope :arguments, lambda {
    { :conditions => ['type = ? OR type = ?', 'ProArgument', 'ContraArgument'] } }
  named_scope :pro_arguments, lambda {
    { :conditions => { :type => 'ProArgument' } } }
  named_scope :contra_arguments, lambda {
    { :conditions => { :type => 'ContraArgument' } } }
  
  
  # limits statements to those being published, except the user is allowed to see unpublished statements
  named_scope :published, lambda {|auth| 
    { :conditions => { :state => @@state_lookup[:published] } } unless auth }

  # orders

  named_scope :by_ratio, :include => :echo, :order => '(echos.supporter_count/echos.visitor_count) DESC'

  named_scope :by_supporters, :include => :echo, :order => 'echos.supporter_count DESC'

  # category

  named_scope :from_category, lambda { |value|
    { :include => :category, :conditions => ['tags.value = ?', value] } }
  
  ## ACCESSORS
  
  # returns the statement documents title
  def title
    self.document.title
  end

  # returns the statement documents text
  def text
    self.document.text
  end

  # simple hack to gain the level
  # problem is: as we can't use nested set (too write intensive stuff), we can't easily get the statements level in the tree
  def level  
    level = 0
    level += 1 if self.parent
    level += 1 if self.root && self.root != self && self.root != self.parent
    level
  end

  ##
  ## STATES
  ##
  
  cattr_reader :states, :state_lookup
  
  # Map the different states of statements to their database representation
  # value.
  # TODO: translate them ..
  @@states = [:new, :published]
  @@state_lookup = { :new => 0, :published => 1 }
  
  # Validate that state is correct
  validates_inclusion_of :state, :in => Statement.state_lookup.values
  
  ##
  ## VALIDATIONS
  ##

  validates_presence_of :creator
  validates_associated :creator
  validates_presence_of :document
  validates_associated :document
  validates_presence_of :category
  
  def validate
    # except of questions, all statements need a valid parent
    errors.add("Parent of #{self.class.name} must be of one of #{self.class.valid_parents.inspect}") unless self.class.valid_parents and self.class.valid_parents.select { |k| parent.instance_of?(k.to_s.constantize) }.any?
  end

  # recursive method to get all parents...
  def parents(parents = [])
    obj = self
    while obj.parent && obj.parent != obj
      parents << obj = obj.parent
    end
    parents.reverse!
  end

  # returns self with all parents
  def self_with_parents()
    list = parents([self])
    list.size == 1 ? list.pop : list
  end

  class << self
    def valid_parents
      @@valid_parents[self.name]
    end

    def expected_children
      @@expected_children[self.name]
    end

    def default_scope
      { :include => :echo,
        :order => %Q[echos.supporter_count DESC, created_at ASC] }
    end
    
    def display_name
      self.name.underscore.gsub(/_/,' ').split(' ').each{|word| word.capitalize!}.join(' ')
    end
    
    def expected_parent_chain
      chain = []
      obj_class = self.name.constantize
      while !obj_class.valid_parents.first.nil?
        chain << obj = self.valid_parents.first
      end
      chain
    end

    private
    # takes an array of class names that are valid for the parent association.
    # the class names should either be strings or symbols, no constants. They
    # will be constantized within the instance, hence won't place a loading
    # constraint on the models (which might lead to loops in our case)
    def validates_parent(*klasses)
      @@valid_parents ||= { }
      @@valid_parents[self.name] ||= []
      @@valid_parents[self.name] += klasses
    end

    # takes an array of class names that are expected to be children of this class
    # this could also be generated by checking all other subclasses valid_parents
    # but i think it is more convenient to define them extra
    # at the moment we only show one type of children in the questions children container (view)
    # therefor we will look for the first element of the expected_children array
    def expects_children(*klasses)
      @@expected_children ||= { }
      @@expected_children[self.name] ||= []
      @@expected_children[self.name] += klasses
    end
  end
end
