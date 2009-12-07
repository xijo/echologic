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
    when 'ProArgument'
      new_pro_argument_proposal_url(parent)
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

  ## ProArgument

  def new_pro_argument_proposal_url(parent)
    raise ArgumentError.new("Expected `parent' to be a Proposal (is: #{parent})") unless parent.kind_of?(Proposal)
    raise ArgumentError.new("Expected `parent.parent' to be a Question (is: #{parent.parent})") unless parent.parent.kind_of?(Question)
    new_question_proposal_pro_argument_url(parent.parent, parent)
  end

  ##
  ## LINKS
  ##

  # edited: i18n without interpolation, because of language diffs.
  def create_children_statement_link(statement=nil)
    return unless statement.class.expected_children.any?
    # FIXME: do we need this here? i think normal users can create everything except questions
    #return unless current_user.has_role?(:editor)
    type = 'Question' if statement.nil?
    type ||= statement.class.expected_children.first.to_s
    link_to(I18n.t("discuss.statements.create_#{type.underscore}_link"),
            new_child_statement_url(statement, type),
            :id => "create_#{type.underscore}_link",
            :class => "ajax text_button #{create_statement_button_class(type)}")
  end

  # this classname is needed to display the right icon next to the link
  def create_statement_button_class(type)
    "create_#{type.underscore}_button"
  end

  def create_question_link_for(category)
    return unless current_user.has_role?(:editor)
    link_to(I18n.t("discuss.statements.create_question_link", :type => Question.display_name),
            new_question_url(:category => category.value), :class=>'ajax text_button create_question_button')
  end

  def edit_statement_link(statement)
    link_to(I18n.t('application.general.edit'), edit_statement_path(statement),
            :class => 'ajax header_button text_button edit_button edit_statement_button') if current_user.may_edit?(statement)
  end


  ## CONVENIENCE and UI

  def statement_icon(statement, size = :medium)
    # remove me to have different sizes again
    image_tag("page/discuss/#{statement.class.name.underscore}_#{size.to_s}.png")
  end

  # Alternative implementation
  # TODO decide which one to use
  def children_box_title(statement)
    type = statement.class.expected_children.first.to_s.underscore
    I18n.t("discuss.statements.headings.#{type}")
  end

  # Inserts a support ratio bar with the ratio value in its alt-attribute.
  def supporter_ratio_bar(statement,context=nil)
    if statement.supporter_count < 2
      tooltip = I18n.t('discuss.statements.echo_indicator_tooltip.one', :supporter_count => statement.supporter_count)
    else
      tooltip = I18n.t('discuss.statements.echo_indicator_tooltip.many', :supporter_count => statement.supporter_count)
    end
    if statement.ratio > 1
      val = "<span class='echo_indicator ttLink' title='#{tooltip}' alt='#{statement.ratio}'></span>"
    else
      val = "<span class='no_echo_indicator ttLink' title='#{tooltip}'></span>"
    end
  end

  # TODO: instead of adding an image tag, we should use css classes here, like (almost) everywhere else
  # TODO: find out why statement.question? works, but not statement.parent.question? or deprecate statement.question?
  # possible answer: method is private - invoking .send :question? on parent does the trick!

  # DEPRICATED, user statement_context_link instead
  def statement_context_line(statement)
    link = link_to(statement_icon(statement, :small)+statement.title, url_for(statement), :class => 'ajax')
    link << supporter_ratio_bar(statement,'context') unless statement.class.name == 'Question'
    return link
  end

  # Returns the context menu link for this statement.
  def statement_context_link(statement)
    link = link_to(statement.title, url_for(statement), :class => "ajax statement_link #{statement.class.name.underscore}_link")
    link << supporter_ratio_bar(statement,'context') unless statement.class.name == 'Question'
    return link
  end

  def statement_dom_id(statement)
    "#{statement.parent.class.name.downcase}_#{statement.id}"
  end

  # Insert prev/next buttons for the current statement.
  def prev_next_buttons(statement)
    key   = ("current_" + statement.class.to_s.underscore).to_sym
    if session[key].present? and session[key].include?(statement.id)
      index = session[key].index(statement.id)

      p = statement_button(session[key][index-1], 'Prev') unless index==0
      n = statement_button(session[key][index+1], 'Next') unless index==session[key].length-1

      "&lt; #{p} - &gt; #{n}"
    end
  end

  # Insert a button that links to the previous statement
  # TODO AR from the helper stinks, but who knows a better way to get the right url?
  # maybe one could code some statement.url method..?
  def statement_button(id, title)
    stmt = Statement.find(id)
    return link_to(title, url_for(stmt), :class => 'ajax')
  end

end
