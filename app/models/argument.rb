# abstract
class Argument < Statement
  validates_parent :Proposal, :ImprovementProposal
end
