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
      format.js {
        render :update do |page|
          page.replace_html "web_profile_#{@web_profile.id}", :partial => 'web_profile', :locals => { :web_profile => @web_profile }
        end
      }
    end
  end

  # GET /web_profiles/new
  # GET /web_profiles/new.xml
  def new
    @web_profile = WebProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @web_profile }
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

    if @web_profile.save
      render :update do |page|
        page.insert_html :bottom, 'webProfileList', :partial => 'web_profile', :locals => { :web_profile => @web_profile }
      end
    end
  end

  # PUT /web_profiles/1
  # PUT /web_profiles/1.xml
  # TODO mass assignment perhaps security issue
  def update
    @web_profile = WebProfile.find(params[:id])

    respond_to do |format|
      if @web_profile.update_attributes(params[:web_profile])
        flash[:notice] = 'WebProfile was successfully updated.'
        format.html { redirect_to(profile_path) }
        format.js { 
          render :update do |page|
            page.replace_html "web_profile_#{@web_profile.id}", :partial => "web_profile", :locals => { :web_profile => @web_profile }
          end
        }
        
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @web_profile.errors, :status => :unprocessable_entity }
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
