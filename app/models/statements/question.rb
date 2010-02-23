# Specification of a Question

# * though the class is called Question, it is commonly refered to as a 'Debate' (in ui, and in concepts).
# * currently a Debate only expects one type of children, Proposals

class Question < Statement
  
  
  # methods / settings to overwrite default statement behaviour
  
  validates_parent :Question, :NilClass
  expects_children :Proposal
  named_scope(:roots, lambda { { :conditions => { :root_id => nil } } })
  
  
  # the default scope defines basic rules for the sql query sent on this model
  # for questions we do not need to include the echo, and we don't order by supporters count, as they are not supportable
  def self.default_scope
    { :order => %Q[created_at ASC] }
  end
  
  # uncomment and overwrite me to change this subclasses display name...
  # default is: self.name.underscore.gsub(/_/,' ').split(' ').each{|word| word.capitalize!}.join(' ')
  
  # def display_name
  #   super
  # end
  
end
