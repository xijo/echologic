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
  end
  
  def show
    current_user.visited!(@statement)
    @page = params[:page] || 1
    @statements = @statement.children.by_ratio.paginate(:page => @page, :per_page => 3)
    respond_to do |format|
      format.html {}
      format.js {
        render :update do |page|
          page.replace_html 'children_list', :partial => 'statements/children_list'
          page.replace_html 'context', :partial => 'statements/context'
          page.replace_html 'summary', :partial => 'statements/summary'
          page.replace_html 'sidebar', :partial => 'statements/sidebar'
          # TODO: i manually show (and empty) the notice here, because it does not load automatically via ajax
          # -> check for a better solution
          page << "info('#{flash[:notice]}');"
          flash[:notice]=nil
        end
      }
    end
  end

  def echo
    current_user.supported!(@statement)
    render :update do |page|
      page.replace('echo_button', echo_button(@statement))
    end
  end
  
  def unecho
    current_user.echo!(@statement, :supported => false)
    render :update do |page|
      page.replace('echo_button', echo_button(@statement))
    end
  end
  
  def new
    @statement ||= statement_class.new :parent => parent
    respond_to do |format|
      format.html { }
      format.js { 
        render :update do |page|
          page.replace_html 'new_statement', :partial => 'statements/new'
        end
      }
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
