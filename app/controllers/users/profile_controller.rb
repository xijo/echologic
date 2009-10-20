class Users::ProfileController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update, :get_personal, :welcome, :upload_picture, :reload_pictures]
  
  access_control do
    allow logged_in # Logged in persons are allowed to modify their profile
  end

  def welcome
    render
  end

  # Shows details for the current user, this action is formaly known as
  # profile! ;)
  def show
    @user = @current_user
    respond_to do |format|
      format.html
      format.js do 
        replace_container('personal_container', :partial => 'personal_information')
      end
    end
  end

  # Edit the profile details through rendering the edit partial to the
  # corresponding part of the profiles page.
  def edit
    @user = @current_user
    respond_to do |format|
      format.html do
        render :partial => "edit", :layout => "application"
      end
      format.js do
        replace_container('personal_container', :partial => 'edit')
      end
    end
  end

  # Set the values from the edit form to the users attributes.
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      respond_to do |format|
        format.html do
          flash[:notice] = "Profile information saved."
          redirect_to profile_path
        end
        format.js do
          replace_container('personal_container', :partial => 'personal_information', :locals => { :user => @user })
        end
      end
    end
  end

  # Calls a js template which opens the upload picture dialog.
  def upload_picture
    @user = current_user
    respond_to do |format|
      format.js do 
        render :template => 'users/profile/upload_picture'
      end
    end
  end

  # After uploading a the profile picture has to be reloaded.
  # Reloading:
  #  1. loginContainer with users picture as profile link
  #  2. picture container of the profile
  def reload_pictures
    @user = current_user
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace 'loginContainer', :partial => 'users/user_sessions/login'
          page.replace 'picture_container', :partial => 'picture'
        end
      end
    end
  end

end
