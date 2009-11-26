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
    return unless current_user.has_role?(:editor)
    type = 'Question' if parent.nil?
    type ||= parent.class.expected_children.first.to_s
    type_display_name = type.constantize.display_name
    link_to(I18n.t("discuss.statement.create_a_new", :type => type_display_name),
            new_child_statement_url(parent, type),
            :id => "create_#{type.underscore}_link", :class => "ajax header_button text_button create_statement_button #{create_statement_class(type)}")
  end
  
  # this classname is needed to display the right icon next to the link
  def create_statement_class(type)
    "create_#{type.underscore}_button"
  end  
  
  def create_question_link_for(category)
    link_to(I18n.t("discuss.statement.create_a_new", :type => Question.display_name), new_question_url(:category => category.value), :class=>'statement_link question_link') if current_user.has_role?(:editor)
  end
  
  def edit_statement_link(statement)
    link_to(I18n.t('application.general.edit'), edit_statement_path(statement), :class => 'ajax header_button text_button edit_button edit_statement_button') if current_user.has_role?(:editor) &&
      (current_user.has_role?(:censor) || current_user.is_author?(statement))
  end
  
  def statement_child_line(statement)
    ret = link_to(statement.title, url_for(statement), :class=>"statement_link #{statement.class.name.underscore}_link")
    ret << supporter_ratio_bar(statement)
  end
  
  ## CONVENIENCE and UI
    
  def statement_icon(statement, size = :medium)
    # remove me to have different sizes again
    size = :medium
    image_tag("page/discuss/#{statement.class.name.underscore.downcase}_#{size.to_s}.png")
  end
  
  def children_box_title(type)
    case type
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
    val =  "<span id='ratiobar#{context}_#{statement.id}' class='ttLink ratiobar ratiobar_#{context}' title='#{tooltip}'></span>"
    val += "<script type='text/javascript'>$('#ratiobar#{context}_#{statement.id}').progressbar({value: #{statement.ratio != 0 ? statement.ratio : 1}});</script>"
    val
  end
  
  # TODO: instead of adding an image tag, we should use css classes here, like (almost) everywhere else
  # TODO: find out why statement.question? works, but not statement.parent.question? or deprecate statement.question?
  def statement_context_line(statement)
    ret = link_to(statement_icon(statement)+statement.title, url_for(statement))
    ret << supporter_ratio_bar(statement,'context') unless statement.class.name == 'Question'
    return ret
  end
  
end
