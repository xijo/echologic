class StatementsController < ApplicationController
  helper :echo
  include EchoHelper

  # remodelling the RESTful constraints, as a default route is currently active
  verify :method => :get, :only => [:index, :show, :new, :edit]
  verify :method => :post, :only => :create
  verify :method => :put, :only => [:update, :echo]
  verify :method => :delete, :only => [:delete, :unecho]

  before_filter :require_user, :only => [:new, :create, :show, :edit, :update]

  before_filter :fetch_statement, :only => [:show, :edit, :update, :echo, :unecho]

  include StatementHelper

  # nested resource magic happens here.
  # not sure if it will work out, maybe we need to push some specific
  # logic towards the subclassed controllers

  def index
    @statements = statement_class.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # TODO visited! throws error with current fixtures.
  def show
    #current_user.visited!(@statement)
    @page = params[:page] || 1
    @statements = @statement.children.by_ratio.paginate(:page => @page, :per_page => 3)
    respond_to do |format|
      format.html { render :template => 'statements/show' } # show.html.erb
      format.js   { render :template => 'statements/show' } # show.js.erb
    end
  end

  # Called if user supports this statement. Updates the support field in the corresponding
  # echo object.
  def echo
    current_user.supported!(@statement)
    respond_to do |format|
      format.html { redirect_to @statement }
      format.js   { replace_container('echo_button', echo_button(@statement)) }
    end
  end

  # Called if user doesn't support this statement any longer. Sets the supported field
  # of the corresponding echo object to false.
  def unecho
    current_user.echo!(@statement, :supported => false)
    respond_to do |format|
      format.html { redirect_to @statement }
      format.js   { replace_container('echo_button', echo_button(@statements)) }
    end
  end

  # Create a new statement
  def new
    @statement ||= statement_class.new :parent => parent
    respond_to do |format|
      format.html # new.html.erb
      format.js   { replace_container('new_statement', :partial => 'statements/new') }
    end
  end

  def create
    @statement = statement_class.new(params[statement_class_param])
    @statement.creator = @statement.document.author = current_user
    @statement.save!
    flash[:notice] = "#{statement_class.display_name} created."
    respond_to do |format|
      format.html { redirect_to url_for(@statement) }
      format.js { show }
    end
  rescue ActiveRecord::RecordInvalid => exc
    flash[:errors] = "Failed to save #{statement_class}: #{exc.message}"
    render :action => 'new'
  end

  def edit
  end

  def update
    @statement.update_attributes!(params[statement_class_param])
    redirect_to url_for(@statement)
  rescue ActiveRecord::RecordInvalid => exc
    flash[:errors] = "Failed to save #{statement_class}: #{exc.message}"
    render :action => 'edit'
  end

  def delete
    statement_class.delete(params[:id])
  end

  #
  # PROTECTED
  #
  protected

  def fetch_statement
    @statement = statement_class.find(params[:id])
  end

  def statement_class
    params[:controller].singularize.camelize.constantize
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
