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
            :class => "ajax header_button text_button #{create_statement_button_class(type)} ttLink", 
            :title => I18n.t("discuss.statements.create_#{type.underscore}_tooltip"))
  end

  # this classname is needed to display the right icon next to the link
  def create_statement_button_class(type)
    "create_#{type.underscore}_button"
  end

  def create_question_link_for(category)
    return unless current_user.has_role?(:editor)
    link_to(I18n.t("discuss.statements.create_question_link", :type => Question.display_name),
            new_question_url(:category => category.value), :class=>'ajax text_button create_question_button ttLink', :title => I18n.t("discuss.statements.create_question_tooltip"))
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

  # Returns the block heading for the children of the given statement
  def children_box_title(statement)
    type = statement.class.expected_children.first.to_s.underscore
    I18n.t("discuss.statements.headings.#{type}")
  end

  # Returns the block heading for entering a new child for the given statement
  def children_new_box_title(statement)
    type = statement.class.to_s.underscore
    I18n.t("discuss.statements.new.#{type}")
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
    link = link_to(statement.title, url_for(statement), :class => "ajax no_border statement_link #{statement.class.name.underscore}_link ttLink", :title => I18n.t("discuss.statements.back_to_#{statement.class.name.underscore}_tooltip"))
    link << supporter_ratio_bar(statement,'context') unless statement.class.name == 'Question'
    return link
  end

  def statement_dom_id(statement)
    "#{statement.parent.class.name.downcase}_#{statement.id}"
  end

  # Insert prev/next buttons for the current statement.
  def prev_next_buttons(statement)
    type = statement.class.to_s.underscore
    key   = ("current_" + type).to_sym
    if session[key].present? and session[key].include?(statement.id)
      index = session[key].index(statement.id)
      buttons = if index == 0
                  prev_statement_tag(type,true)
                else
                  statement_button(session[key][index-1], prev_statement_tag(type), :class => "prev_stmt", :rel => 'prev')
                end
      buttons << if index == session[key].length-1
                   next_statement_tag(true)
                 else
                   statement_button(session[key][index+1], next_statement_tag(type), :class => 'next_stmt', :rel => 'next')
                 end
    end
  end
  
  def prev_statement_tag(class_identifier, disabled=false)
    content_tag(:span, '&nbsp;', :class => "prev_stmt no_border#{disabled ? ' disabled' : ' ttLink'}", :title => I18n.t("discuss.statements.prev_#{class_identifier}_tooltip"))  
  end
  
  def next_statement_tag(class_identifier, disabled=false)
    content_tag(:span, '&nbsp;', :class => "next_stmt no_border#{disabled ? ' disabled' : ' ttLink'}", :title => I18n.t("discuss.statements.next_#{class_identifier}_tooltip")) 
  end

  # Insert a button that links to the previous statement
  # TODO AR from the helper stinks, but who knows a better way to get the right url?
  # maybe one could code some statement.url method..?
  def statement_button(id, title, options={})
    stmt = Statement.find(id)
    options[:class] ||= ''
    options[:class] += ' ajax'
    return link_to(title, url_for(stmt), options)
  end

end
