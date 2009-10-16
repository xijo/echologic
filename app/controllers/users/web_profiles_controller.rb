class Users::WebProfilesController < ApplicationController

  before_filter :require_user, :only => [:edit, :create, :update, :destroy]

  access_control do
    allow logged_in
  end

  # GET /web_profiles/1
  # GET /web_profiles/1.xml
  def show
    @web_profile = WebProfile.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.js do
        render :update do |page|
          page.replace_html "web_profile_#{@web_profile.id}", :partial => 'web_profile', :locals => { :web_profile => @web_profile }
        end
      end
    end
  end

  # GET /web_profiles/new
  # GET /web_profiles/new.xml
  def new
    @web_profile = WebProfile.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /web_profiles/1/edit
  def edit
    @user = @current_user
    @web_profile = WebProfile.find(params[:id])
    render :update do |page|
      page.replace_html "web_profile_#{@web_profile.id}", :partial => 'edit', :locals => { :web_profile => @web_profile }
    end
  end

  # POST /web_profiles
  # POST /web_profiles.xml
  def create
    @web_profile = WebProfile.new(params[:web_profile])
    @web_profile.user_id = @current_user.id

    render :update do |page|
      if @web_profile.save
        page.insert_html :bottom, 'webProfileList', :partial => 'web_profile', :locals => { :web_profile => @web_profile }
      else
        show_javascript_errors(@web_profile, page)
      end
    end
  end

  # PUT /web_profiles/1
  # PUT /web_profiles/1.xml
  def update
    @web_profile = WebProfile.find(params[:id])

    render :update do |page|
      if @web_profile.update_attributes(params[:web_profile])
        page.replace_html "web_profile_#{@web_profile.id}", :partial => @web_profile
      else
        show_javascript_errors(@web_profile, page)
      end
    end
  end

  # DELETE /web_profiles/1
  def destroy
    @web_profile = WebProfile.find(params[:id])
    id = @web_profile.id
    @web_profile.destroy

    render :update do |page|
      page.remove "web_profile_#{id}"
    end

  end
end
