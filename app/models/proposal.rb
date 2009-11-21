class Proposal < Statement
  validates_parent :Question
  expects_children :ImprovementProposal
end
