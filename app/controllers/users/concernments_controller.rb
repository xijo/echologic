class Users::ConcernmentsController < ApplicationController
  # GET /concernments
  # GET /concernments.xml
  def index
    @concernments = Concernment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @concernments }
    end
  end

  # GET /concernments/1
  # GET /concernments/1.xml
  def show
    @concernment = Concernment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @concernment }
    end
  end

  # GET /concernments/new
  # GET /concernments/new.xml
  def new
    @concernment = Concernment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @concernment }
    end
  end

  # GET /concernments/1/edit
  def edit
    @concernment = Concernment.find(params[:id])
  end

  # POST /concernments
  # POST /concernments.xml
  def create
    @concernment = Concernment.new(params[:concernment])

    respond_to do |format|
      if @concernment.save
        flash[:notice] = 'Concernment was successfully created.'
        format.html { redirect_to(@concernment) }
        format.xml  { render :xml => @concernment, :status => :created, :location => @concernment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @concernment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /concernments/1
  # PUT /concernments/1.xml
  def update
    @concernment = Concernment.find(params[:id])

    respond_to do |format|
      if @concernment.update_attributes(params[:concernment])
        flash[:notice] = 'Concernment was successfully updated.'
        format.html { redirect_to(@concernment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @concernment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /concernments/1
  # DELETE /concernments/1.xml
  def destroy
    @concernment = Concernment.find(params[:id])
    @concernment.destroy

    respond_to do |format|
      format.html { redirect_to(concernments_url) }
      format.xml  { head :ok }
    end
  end
end
