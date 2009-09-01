class LocalesController < ActionController::Base
  helper :all
  layout 'translations'

  prepend_view_path(File.join(File.dirname(__FILE__), "..", "views"))
  # GET /locales
  # GET /locales.xml
  def index
    @locales = Locale.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locales }
    end
  end

  # GET /locales/1
  # GET /locales/1.xml
  def show
    @locale = Locale.find_by_code(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @locale }
    end
  end

  # GET /locales/new
  # GET /locales/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @locale }
    end
  end

  # GET /locales/1/edit
  def edit
    @locale = Locale.find_by_code(params[:id])
  end

  # Explicit setting of attributes because 'locale' is preserved for application
  # usage and must not be used for auto forms.
  # 
  # POST /locales
  #
  def create
    @locale = Locale.new
    @locale.code = params[:code]
    @locale.name = params[:name]

    respond_to do |format|
      if @locale.save
        flash[:notice] = 'Locale was successfully created.'
        format.html { redirect_to(locales_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /locales/1
  # PUT /locales/1.xml
  def update
    @locale = Locale.find_by_code(params[:id])
    updates = Hash.new
    updates[:code] = params[:code]
    updates[:name] = params[:name]
    
    respond_to do |format|
      if @locale.update_attributes(updates)
        flash[:notice] = 'Locale was successfully updated.'
        format.html { redirect_to(locales_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @locale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locales/1
  # DELETE /locales/1.xml
  def destroy
    @locale = Locale.find_by_code(params[:id])
    @locale.destroy

    respond_to do |format|
      format.html { redirect_to(locales_url) }
      format.xml  { head :ok }
    end
  end
end
