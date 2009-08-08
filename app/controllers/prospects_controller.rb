class ProspectsController < ApplicationController
  # GET /prospects
  # GET /prospects.xml
  def index
    @prospects = Prospect.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prospects }
    end
  end

  # GET /prospects/1
  # GET /prospects/1.xml
  def show
    @prospect = Prospect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prospect }
    end
  end

  # GET /prospects/new
  # GET /prospects/new.xml
  def new
    @prospect = Prospect.new

    respond_to do |format|
      format.html { render :partial => 'prospects/new', :layout => 'static' }
      format.xml  { render :xml => @prospect }
      format.js { render :template => 'static_content/outer_menu' , :locals => { :menu_item => 'prospects/new' } }
    end
  end

  # GET /prospects/1/edit
  def edit
    @prospect = Prospect.find(params[:id])
  end

  # POST /prospects
  # POST /prospects.xml
  def create
    @prospect = Prospect.new(params[:prospect])

    respond_to do |format|
      if @prospect.save
        flash[:notice] = 'Prospect was successfully created.'
        format.html { redirect_to(@prospect) }
        format.xml  { render :xml => @prospect, :status => :created, :location => @prospect }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prospect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prospects/1
  # PUT /prospects/1.xml
  def update
    @prospect = Prospect.find(params[:id])

    respond_to do |format|
      if @prospect.update_attributes(params[:prospect])
        flash[:notice] = 'Prospect was successfully updated.'
        format.html { redirect_to(@prospect) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prospect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prospects/1
  # DELETE /prospects/1.xml
  def destroy
    @prospect = Prospect.find(params[:id])
    @prospect.destroy

    respond_to do |format|
      format.html { redirect_to(prospects_url) }
      format.xml  { head :ok }
    end
  end
end
