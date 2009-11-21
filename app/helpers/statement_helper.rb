module StatementHelper
  def proposal_path(proposal)
    question_proposal_path(proposal.parent,proposal)
  end
  
  def proposal_url(proposal)
    question_proposal_url(proposal.parent,proposal)
  end
  
  def improvement_proposal_url(proposal)
    question_proposal_improvement_proposal_url(proposal.root,proposal.parent,proposal)
  end
  
  def improvement_proposal_path(proposal)
    question_proposal_improvement_proposal_path(proposal.root,proposal.parent,proposal)
  end
  
  def new_proposal_url(parent)
    new_question_proposal_url(parent)
  end
  
  def new_improvement_proposal_url(parent)
    new_question_proposal_improvement_proposal_url(parent.parent,parent)
  end
  
  def statement_icon(statement, size = :medium)
    image_tag("statements/#{statement.class.name.downcase}_#{size.to_s}.png")
  end
  
  def create_statement_link(parent, type)
    link_to('Create a new '+type.to_s.constantize.display_name,new_child_statement_url(parent, type))
  end
  
  def new_child_statement_url(parent, type)
    case type.to_s.constantize.name
    when 'Proposal'
      new_proposal_url(parent)
    when 'ImprovementProposal'
      new_improvement_proposal_url(parent)
    end
  end
  
  def children_box_title(type)
    case type.to_s.constantize.name
    when 'Question'
      'Proposals'
    when 'Proposal'
      'Improvement Proposals'
    end
    
  end
    
end
