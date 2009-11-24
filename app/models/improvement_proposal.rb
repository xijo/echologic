class ImprovementProposal < Proposal
  validates_parent :Proposal
  expects_children
end
