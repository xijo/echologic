module StatementHelper
  def proposal_path(proposal)
    question_proposal_path(proposal.parent,proposal)
  end
  
  def improvement_proposal_path(proposal)
    question_proposal_improvement_proposal_path(proposal.root,proposal.parent,proposal)
  end
end
