# Specification of a Proposal

# * Proposals can be either seen as Proposals or as Positions (/Standpoints) as which they are commonly refered to in concepts and ui
# * currently a Position expects only Improvement Proposals as valid children, and only Questions as parents


class Proposal < Statement
  
  # methods / settings to overwrite default statement behaviour
    
  validates_parent :Question
  expects_children :ImprovementProposal
  
  # the default scope defines basic rules for the sql query sent on this model
  # for questions we do not need to include the echo, and we don't order by supporters count, as they are not supportable
  
  # def self.default_scope
  #   super
  # end
  
  # uncomment and overwrite me to change this subclasses display name...
  # default is: self.name.underscore.gsub(/_/,' ').split(' ').each{|word| word.capitalize!}.join(' ')
  
  # def display_name
  #   super
  # end
  
end
