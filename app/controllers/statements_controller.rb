class StatementsController < ApplicationController
  helper :echo
  include EchoHelper

  # remodelling the RESTful constraints, as a default route is currently active
  # FIXME: the echo and unecho actions should be accessible via PUT/DELETE only,
  #        but that is currently undoable without breaking non-js requests. A
  #        solution would be to make the "echo" button a real submit button and
  #        wrap a form around it.
  verify :method => :get, :only => [:index, :show, :new, :edit, :category]
  verify :method => :post, :only => :create
  verify :method => :put, :only => [:update]
  verify :method => :delete, :only => [:delete]

  # FIXME: we don't need this line anymore if we have the access_control block, right?
  #  before_filter :require_user, :only => [:new, :create, :show, :edit, :update]

  # the order of these filters matters. change with caution.
  before_filter :fetch_statement, :only => [:show, :edit, :update, :echo, :unecho]
  before_filter :fetch_category, :only => [:index, :new, :show, :edit, :update]

  # make custom URL helper available to controller
  include StatementHelper

  access_control do
    allow :editor
    allow logged_in, :only => [:index, :show, :echo, :unecho]
    allow logged_in, :only => [:new, :create], :unless => :is_question?
    allow logged_in, :only => [:edit, :update], :if => :may_edit?
    allow logged_in, :only => [:delete], :if => :may_delete?
  end
  
  # FIXME: I tink this method is never used - it should possibly do nothing, or redirect to category...
  def index
    @statements = statement_class.all(statement_class.default_scope).published(current_user.has_role?(:editor)).by_supporters.paginate(:page => @page, :per_page => 6)
    respond_to do |format|
      format.html { render :template => 'questions/index' }
    end

  end

  # TODO use find or create category tag?
  def category
    @category = Tag.find_or_create_by_value(params[:id])
    redirect_to(:controller => 'discuss', :action => 'index') and return unless @category
    @page = params[:page] || 1
    @statements = statement_class.from_category(params[:id]).published(current_user.has_role?(:editor)).by_supporters.paginate(:page => @page, :per_page => 3)
    respond_to do |format|
      format.html {render :template => 'questions/index'}
      format.js {
        replace_container('question_container', :partial => 'questions/questions')
      }
    end
  end

  # TODO visited! throws error with current fixtures.
  def show
    current_user.visited!(@statement)
    unless @statement.children.empty?
      child_type = ("current_" + @statement.class.expected_children.first.to_s.underscore).to_sym
      # FIXME: why is this necessary?
      session[child_type] = @statement.children.by_supporters.collect { |c| c.id }
    end

    @page = params[:page] || 1
    # find alle child statements, which are published (except user is an editor) sorted by supporters count, and paginate them
    @children = @statement.children.published(current_user.has_role?(:editor)).by_supporters.paginate(Statement.default_scope.merge(:page => @page, :per_page => 3))
    respond_to do |format|
      format.html { render :template => 'statements/show' } # show.html.erb
      format.js   { render :template => 'statements/show' } # show.js.erb
    end
  end

  # Called if user supports this statement. Updates the support field in the corresponding
  # echo object.
  def echo
    return if @statement.question?
    current_user.supported!(@statement)
    respond_to do |format|
      format.html { redirect_to @statement }
      format.js { render :template => 'statements/echo' }
    end
  end

  # Called if user doesn't support this statement any longer. Sets the supported field
  # of the corresponding echo object to false.
  def unecho
    return if @statement.question?
    current_user.echo!(@statement, :supported => false)
    respond_to do |format|
      format.html { redirect_to @statement }
      format.js { render :template => 'statements/echo' }
    end  
  end

  # Create a new statement
  def new
    @statement ||= statement_class.new(:parent => parent, :category_id => @category.id)
    @statement.create_document
    respond_to do |format|
      format.html { render :template => 'statements/new' }
      if is_question?
        #FIXME: i changed this from questions/new to statements/new again, beaucse statements/new was messed up, and i didn't see a point in a sperate partial for questions
        format.js { replace_container('new_statement', :partial => 'statements/new') }
      else
        format.js { replace_container('new_statement', :partial => 'statements/new') }
      end
    end
  end

  def create
    attrs = params[statement_class_param]
    attrs[:state] = Statement.state_lookup[:published] unless statement_class == Question
    @statement = statement_class.new(attrs)
    @statement.creator = @statement.document.author = current_user
    
    respond_to do |format|
      if @statement.save
        set_info("discuss.messages.created", :type => @statement.class.human_name)
        current_user.supported!(@statement)
        # render parent statement after creation, if any
        @statement = @statement.parent if @statement.parent
        format.html { flash_info and redirect_to url_for(@statement) }
        format.js   { show }
      else
        set_error(@statement.document)
        format.html { flash_error and render :template => 'statements/new' }
        format.js   { show_error_messages }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html { render :template => 'statements/edit' }
      format.js { replace_container('summary', :partial => 'statements/edit') }
    end
  end

  def update
    attrs = params[statement_class_param]
    (attrs[:document] || attrs[:statement_document])[:author] = current_user
    respond_to do |format|
      if @statement.update_attributes(attrs)
        set_info("discuss.messages.updated", :type => @statement.class.human_name)
        format.html { flash_info and redirect_to url_for(@statement) }
        format.js   { show }
      else
        set_error(@statement.document)
        format.html { flash_error and redirect_to url_for(@statement) }
        format.js   { show_error_messages }
      end
    end
  end

  def delete
    statement_class.delete(params[:id])
  end

  #
  # PRIVATE
  #
  private

  def fetch_statement
    @statement ||= statement_class.find(params[:id]) if params[:id].try(:any?) && params[:id] =~ /\d+/
  end

  # Fetch current category based on various factors.
  # If the category is supplied as :id, render action 'index' no matter what params[:action] suggests.
  def fetch_category
    @category = if params[:category] # i.e. /discuss/questions/...?category=<tag>
                  Tag.find_by_value(params[:category])
                elsif params[:category_id] # happens on form-based POSTed requests
                  Tag.find(params[:category_id])
                elsif parent || (@statement && ! @statement.new_record?) # i.e. /discuss/questions/<id>
                  @statement.try(:category) || parent.try(:category)
                else
                  nil
                end or redirect_to :controller => 'discuss', :action => 'index'
  end

  def statement_class
    params[:controller].singularize.camelize.constantize
  end

  # Checks if the current controller belongs to a question
  # FIXME: isn't this possible to solve over statement.quesion? already?
  def is_question?
    params[:controller].singularize.camelize.eql?('Question')
  end
  
  def may_edit?
    current_user.may_edit?(@statement)  
  end
  
  def may_delete?
    current_user.may_delete?(@statement)
  end

  def statement_class_param
    statement_class.name.underscore.to_sym
  end

  def parent
    statement_class.valid_parents.each do |parent|
      parent_id = params[:"#{parent.to_s.underscore.singularize}_id"]
      return parent.to_s.constantize.find(parent_id) if parent_id
    end ; nil
  end
end
