class TranslationsController < ApplicationController
  # GET /translations
  # GET /translations.xml
  def index
    @locale = Locale.find(params[:locale_id])
    @translations = @locale.translations

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @translations }
    end
  end

  # GET /translations/1
  # GET /translations/1.xml
  def show
    @locale = Locale.find(params[:locale_id])
    @translation = Translation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  # GET /translations/new
  # GET /translations/new.xml
  def new
    @translation = Translation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  # GET /translations/1/edit
  def edit
    @locale = Locale.find(params[:locale_id])
    @translation = Translation.find(params[:id])
    @english = Translation.find_by_locale_id_and_raw_key(1, @translation.raw_key)
  end

  # POST /translations
  # POST /translations.xml
  def create
    @translation = Translation.new(params[:translation])

    respond_to do |format|
      if @translation.save
        flash[:notice] = 'Translation was successfully created.'
        format.html { locale_translations_path(@translation.locale) }
        format.xml  { render :xml => @translation, :status => :created, :location => @translation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /translations/1
  # PUT /translations/1.xml
  def update
    @translation = Translation.find(params[:id])

    respond_to do |format|
      if @translation.update_attributes(params[:translation])
        flash[:notice] = 'Translation was successfully updated.'
        format.html { redirect_to(locale_translations_path(@translation.locale)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /translations/1
  # DELETE /translations/1.xml
  def destroy
    @translation = Translation.find(params[:id])
    @locale = Translation.locale
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to(locale_translations_path(@locale)) }
      format.xml  { head :ok }
    end
  end


  def filter
    @locale = params[:locale_id]
    @translations = Translation.find(:all,
      :conditions => ['raw_key like ? and locale_id = ?',
        "%#{params[:filter_text]}%", params[:locale_id]])
    render :partial => 'list'
  end


end
