module StatementHelper
  def proposal_path(proposal)
    question_proposal_path(proposal.parent,proposal)
  end

  def proposal_url(proposal)
    question_proposal_url(proposal.parent,proposal)
  end

  def improvement_proposal_url(proposal)
    question_proposal_improvement_proposal_url(proposal.root, proposal.parent, proposal)
  end

  def improvement_proposal_path(proposal)
    question_proposal_improvement_proposal_path(proposal.root, proposal.parent, proposal)
  end

  def new_proposal_url(parent)
    new_question_proposal_url(parent)
  end

  def new_improvement_proposal_url(parent)
    raise ArgumentError.new("Expected `parent' to be a Proposal (is: #{parent})") unless parent.kind_of?(Proposal)
    raise ArgumentError.new("Expected `parent.parent' to be a Question (is: #{parent.parent})") unless parent.parent.kind_of?(Question)
    new_question_proposal_improvement_proposal_url(parent.parent, parent)
  end

  def statement_icon(statement, size = :medium)
    image_tag("statements/#{statement.class.name.downcase}_#{size.to_s}.png")
  end

  def create_statement_link(parent=nil)
    type = 'Question' if parent.nil?
    type ||= parent.class.expected_children.first.to_s
    type_display_name = type.constantize.display_name
    link_to("Create a new #{type_display_name}", new_child_statement_url(parent, type), :id => "create_#{type.underscore}_link", :class => 'ajax')
  end

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

  def children_box_title(type)
    case type.to_s.constantize.name
    when 'Nil'
      'Questions'
    when 'Question'
      'Proposals'
    when 'Proposal'
      'Improvement Proposals'
    end
  end

  # Inserts a support ratio bar with the ratio value in its alt-attribute.
  def supporter_ratio_bar(statement,context=nil)
    tooltip = I18n.t('discuss.statement.ratio_bar_tooltip',
                :progress => statement.ratio, :supporters => statement.supporter_count)
    ratio   = statement.ratio != 0 ? statement.ratio : 1
    val     = "<span class='ttLink ratiobar' title='#{tooltip}' alt='#{ratio}'></span>"
  end

  # Return the dom_id for the statement
  def statement_dom_id(statement)
    if statement.parent.blank?
      "#{statement.class.name.downcase}_#{statement.id}"
    else
      "#{statement.parent.class.name.downcase}_#{statement.id}"
    end
  end

end
