class Users::WebProfilesController < ApplicationController

  before_filter :require_user

  helper :profile
  
  access_control do
    allow logged_in
  end

  # Show the web profile with the given id.
  # method: GET
  def show
    @web_profile = WebProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js do
        replace_content(dom_id(@web_profile), :partial => 'web_profile')
      end
    end
  end

  # Show the new template for web profiles. Currently unused.
  # method: GET
  def new
    @web_profile = WebProfile.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # Show the edit template for the specified web profile.
  # method: GET
  def edit
    @user = @current_user
    @web_profile = WebProfile.find(params[:id])

    respond_to do |format|
      format.js do
        replace_content(dom_id(@web_profile), :partial => 'edit')
      end
    end
  end

  # Create new web profile for the current user.
  # method: POST
  def create
    @web_profile = WebProfile.new(params[:web_profile])
    @web_profile.user_id = @current_user.id

    respond_to do |format|
      format.js do
        if @web_profile.save
          render :template => 'users/profile/create_object', :locals => { :object => @web_profile }
        else
          show_error_messages(@web_profile)
        end
      end
    end
  end

  # Update the web profiles attributes
  # method: PUT
  def update
    @web_profile = WebProfile.find(params[:id])

    respond_to do |format|
      format.js do
        if @web_profile.update_attributes(params[:web_profile])
          replace_content(dom_id(@web_profile), :partial => @web_profile)
        else
          show_error_messages(@web_profile)
        end
      end
    end
  end

  # Remove the web profile specified through id
  # method: DELETE
  def destroy
    @web_profile = WebProfile.find(params[:id])
    id = @web_profile.id
    @web_profile.destroy

    respond_to do |format|
      format.js do
        # sorry, but this was crap. you can't add additional js actions like this...
        # either use a rjs, a js, or a render :update block
        #remove_container "web_profile_#{id}"
        render :template => 'users/profile/remove_object', :locals => { :object => @web_profile }
      end
    end
  end

end
