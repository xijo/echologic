class Users::ProfileController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update, :get_personal, :welcome, :upload_picture, :reload_pictures]

  access_control do
    allow logged_in # Logged in persons are allowed to modify their profile
  end

  # Shows details for the current user, this action is formaly known as
  # profile! ;)
  def show
    @profile = Profile.find(params[:id])
    respond_to do |format|
      format.html { render :partial => "users/profile/profile_own" }
      format.js   { replace_container('personal_container', :partial => 'users/profile/profile_own') }
    end
  end

  def details
    @profile = Profile.find(params[:id], :include => [:web_profiles, :memberships, :concernments, :user])
    respond_to do |format|
      format.js   { render :template => 'connect/profiles/details'}
      format.html { render :partial => 'connect/profiles/details', :layout => 'application' }
    end
  end

  # Edit the profile details through rendering the edit partial to the
  # corresponding part of the profiles page.
  def edit
    @profile = @current_user.profile
    @profile = Profile.find(params[:id]) if current_user.has_role?(:admin)
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
    @profile = @current_user.profile
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { flash[:notice] = I18n.t('users.profile.messages.updated') and redirect_to my_profile_path }
        format.js   { 
          # this was crap, it prevents me from adding additional js functionality 
          ##replace_container('personal_container', :partial => 'users/profile/profile_own') 
          render :update do |page|
            page.replace('personal_container', :partial => 'users/profile/profile_own')
          end
        }
      else
        format.js   { show_error_messages(@profile) }
      end
    end
  end

  # Calls a js template which opens the upload picture dialog.
  def upload_picture
    @user = current_user
    @profile = current_user.profile
    respond_to do |format|
      format.js do
        render :template => 'users/avatar/upload_picture'
      end
    end
  end

  # After uploading the profile picture has to be reloaded.
  # Reloading:
  #  1. loginContainer with users picture as profile link
  #  2. picture container of the profile
  def reload_pictures
    @user = current_user
    @profile = current_user.profile
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace 'loginContainer',    :partial => 'users/user_sessions/login'
          page.replace 'profile_avatar_container', :partial => 'users/avatar/picture'
        end
      end
    end
  end

end
