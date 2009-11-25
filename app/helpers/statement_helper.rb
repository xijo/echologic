module StatementHelper
  def self.included(base)
    base.instance_eval do 
      alias_method :proposal_path, :proposal_url
      alias_method :new_proposal_path, :new_proposal_url
      
      alias_method :improvement_proposal_path, :improvement_proposal_url
      alias_method :new_improvement_proposal_path, :new_improvement_proposal_url
    end
  end
  
  ##
  ## URLS
  ##
  
  def new_child_statement_url(parent, type)
    case type.to_s
    when 'Question'
      new_question_url(parent)
    when 'Proposal'
      new_proposal_url(parent)
    when 'ImprovementProposal'
      new_improvement_proposal_url(parent)
    end
  end
  
  def edit_statement_path(statement)
    case statement.type.to_s
    when 'Question'
      edit_question_path(statement)
    when 'Proposal'
      edit_proposal_path(statement)
    when 'ImprovementProposal'
      edit_improvement_proposal_path(statement)
    else
      raise ArgumentError.new("Unhandled type: #{statement.type}")
    end
  end

  ## Proposal
  
  def proposal_url(proposal)
    question_proposal_url(proposal.parent,proposal)
  end
  
  def new_proposal_url(parent)
    new_question_proposal_url(parent)
  end
  
  def edit_proposal_url(proposal)
    edit_question_proposal_url(proposal.parent, proposal)
  end
  
  def edit_proposal_path(proposal)
    edit_question_proposal_path(proposal.parent, proposal)
  end
  
  ## ImprovementProposal

  def improvement_proposal_url(proposal)
    question_proposal_improvement_proposal_url(proposal.root, proposal.parent, proposal)
  end
  
  def new_improvement_proposal_url(parent)
    raise ArgumentError.new("Expected `parent' to be a Proposal (is: #{parent})") unless parent.kind_of?(Proposal)
    raise ArgumentError.new("Expected `parent.parent' to be a Question (is: #{parent.parent})") unless parent.parent.kind_of?(Question)
    new_question_proposal_improvement_proposal_url(parent.parent, parent)
  end

  def edit_improvement_proposal_url(proposal)
    edit_question_proposal_improvement_proposal_url(proposal.root, proposal.parent, proposal)
  end

  def edit_improvement_proposal_path(proposal)
    edit_question_proposal_improvement_proposal_path(proposal.root, proposal.parent, proposal)
  end

  ##
  ## LINKS
  ##
  
  def create_statement_link(parent=nil)
    type = 'Question' if parent.nil?
    type ||= parent.class.expected_children.first.to_s
    type_display_name = type.constantize.display_name
    link_to(I18n.t("discuss.statement.create_a_new", :type => type_display_name),
            new_child_statement_url(parent, type),
            :id => "create_#{type.underscore}_link")
  end
  
  def create_question_link_for(category)
    link_to(I18n.t("discuss.statement.create_a_new", :type => Question.display_name), new_question_url(:category => category.value))
  end
  
  def edit_statement_link(statement)
    link_to(I18n.t('application.general.edit'), edit_statement_path(statement)) if current_user.has_role?(:editor) &&
      (current_user.has_role?(:censor) || current_user.is_author?(statement))
  end
  
  
  ## CONVENIENCE and UI
    
  def statement_icon(statement, size = :medium)
    image_tag("statements/#{statement.class.name.downcase}_#{size.to_s}.png")
  end
  
  def children_box_title(type)
    case type.to_s.constantize.name
    when 'NilClass'
      'Questions'
    when 'Question'
      'Proposals'
    when 'Proposal'
      'Improvement Proposals'
    end
  end
  
  def supporter_ratio_bar(statement,context=nil)
    tooltip = I18n.t('discuss.statement.ratio_bar_tooltip', :progress => statement.ratio, :supporters => statement.supporter_count)
    val =  "<span id='ratiobar#{context}_#{statement.id}' class='ttLink ratiobar' title='#{tooltip}'></span>"
    val += "<script type='text/javascript'>$('#ratiobar#{context}_#{statement.id}').progressbar({value: #{statement.ratio != 0 ? statement.ratio : 1}});</script>"
    val
  end
  
end
