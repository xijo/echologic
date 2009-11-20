class StatementsController < ApplicationController
  # remodelling the RESTful constraints, as a default route is currently active
  verify :method => :get, :only => [:index, :show, :new, :edit]
  verify :method => :post, :only => :create
  verify :method => :put, :only => :update
  verify :method => :delete, :only => :delete

  before_filter :require_user, :only => [:new, :create, :show, :edit, :update]
  
  before_filter :fetch_statement, :only => [:show, :edit, :update]
  
  def index
    # nested resource magic happens here.
    # not sure if it will work out, maybe we need to push some specific
    # logic towards the subclassed controllers
    if valid_parents = statement_class.valid_parents
      valid_parents.each do |valid_parent|
        parent_id_key = "#{valid_parent.to_s.underscore}_id".to_sym
        if params[parent_id_key]
          @statements = valid_parent.to_s.constantize.send(statement_class.underscore.pluralize)
          break
        end
      end
    else
      @statements = statement_class.all
    end
  end
  
  def show
  end
  
  def new
    @statement ||= statement_class.new
  end
  
  def create
    @statement = statement_class.new(params[statement_class_param])
    @statement.creator = @statement.document.author = current_user
    @statement.save!
    flash[:notice] = "#{statement_class.display_name} created."
    redirect_to url_for(@statement)
  rescue ActiveRecord::RecordNotSaved => exc
    flash[:errors] = "Failed to save #{statement_class}: #{exc.message}"
    render :action => 'new'
  end
  
  def edit
  end
  
  def update
    @statement.update_attributes!(params[statement_class_param])
    redirect_to url_for(@statement)
  rescue ActiveRecord::RecordNotSaved => exc
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
end
