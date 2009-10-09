class Users::ProfileController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update, :get_personal, :welcome]
  
  access_control do
    allow logged_in, :to => [:show, :update, :edit, :get_personal, :welcome]
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
      format.js {
        render :update do |page|
          page.replace_html 'personal', :partial => 'personal_information'
        end
      }
    end
  end

  # Edit the profile details through rendering the edit partial to the
  # corresponding part of the profiles page.
  def edit
    @user = @current_user
    render :update do |page|
      page.replace_html 'personal', :partial => 'edit'
    end
  end

  # Set the values from the edit form to the users attributes.
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile information saved."
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.js {
          render :update do |page|
            page.replace_html 'personal', :partial => 'personal_information', :locals => { :user => @user }
            page << "info('#{flash[:notice]}');"
          end
        }
      end
    end
  end

  # Responds in JS wether with editing or with view partial.
  # TODO depricated, remove?
#  def get_personal(editable=false)
#    @user = @current_user
#    render :update do |page|
#      page.replace_html 'personal', :partial => 'personal_information'
#    end
#  end


end
