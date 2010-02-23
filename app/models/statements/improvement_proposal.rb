# Specification of an ImprovementProposal

# * ImprovementProposals do mostly refer to the actual document / text of a proposal. They do no represent a different standpoint, but more a different approach to formulate one. 
# * currently an Improvementproposal does always refer to a proposal, and does not expect further children


class ImprovementProposal < Statement
  
  # methods / settings to overwrite default statement behaviour
    
  validates_parent :Proposal
  expects_children
  
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
