class Users::ProfileController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update]
  
  access_control do
    allow logged_in, :to => [:show, :update, :edit]
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = @current_user

    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/edit
  def edit
    @user = @current_user
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = @current_user
    puts "\n\nACHTUNG\n\n"
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Profile was successfully updated."
        format.html { redirect_to(profile_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
