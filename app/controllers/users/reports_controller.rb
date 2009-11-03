class Users::ReportsController < ApplicationController

  # All reporting actions require a logged in user
  before_filter :require_user

  # Users may create new reports.
  # Admin may perform everything.
  access_control do
    allow :admin
    allow logged_in, :to => [:new, :create]
  end


  # Show all active and done reports.
  def index
    @done   = Report.done
    @active = Report.active

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # Show a specified user report.
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # Set a suspect for a new report and render the new template.
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
    respond_to do |format|
      format.html { render :partial => 'edit' }
      format.js   { replace_container(dom_id(@report, :edit), :partial => 'edit') }
    end
  end

  # Creates a new report and shows messages.
  def create
    @report = Report.new(params[:report])
    @report.reporter_id = current_user.id
    
    respond_to do |format|
      if @report.save
        format.html { set_notice('users.reports.messages.created') and redirect_to('/connect/search') }
        format.js   # create.js.erb
      else
        format.html { render :action => "new" }
        format.js   { show_error_messages(@report) }
      end
    end
  end

  # Update the reports data, normally: set it done and
  # include one's decision.
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        flash[:notice] = 'Report was successfully updated.'
        format.html { redirect_to reports_path }
      else
        format.html { render :action => "edit" }
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
    end
  end
end
