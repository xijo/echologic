class Users::ReportsController < ApplicationController

  # All reporting actions require a logged in user
  before_filter :require_user

  # Users may create new reports.
  # Admin may perform everything.
  access_control do
    allow :admin
    allow logged_in, :to => [:new, :create]
  end


  # GET /reports
  # GET /reports.xml
  def index
    @reports = Report.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.xml
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.xml
  def new
    @report = Report.new
    @report.suspect_id  = params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.js   # new.js.erb
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /reports
  # POST /reports.xml
  def create
    @report = Report.new(params[:report])
    @report.reporter_id = current_user.id
    
    respond_to do |format|
      if @report.save
        format.html { set_notice('users.reports.messages.created') and redirect_to('/connect/search') }
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.xml
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        flash[:notice] = 'Report was successfully updated.'
        format.html { redirect_to(@report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.xml
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end
end
