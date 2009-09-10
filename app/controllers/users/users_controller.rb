class Users::UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]


  access_control do
    allow logged_in, :to => [:show, :index, :edit_profile]
    allow :admin
    allow anonymous, :to => [:new, :create]
  end



  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = @current_user

    respond_to do |format|
      format.html
    end
  end

  def show_profile
    @user = @current_user
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render :template => 'layouts/tabContainer' }
    end
  end

  # GET /users/1/edit
  def edit
    @user = @current_user
  end

  # GET /profile/edit
  def edit_profile
    @user = @current_user
  end


  # modified users_controller.rb
  # TODO add response_to
  def create
    @user = User.new

    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      render :action => :new
    end
  end
#
#
#
#
#  # POST /users
#  # POST /users.xml
#  # TODO cleanup signup process.
#  def create
#    @user = User.new(params[:user])
#
#    respond_to do |format|
#      #if @user.save
#      if @user.save_without_session_maintenance
#        @user.deliver_activation_instructions!
#        flash[:notice] = 'User was successfully created.'
#        #format.html { redirect_to(@user) }
#        format.html { redirect_to root_url }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = @current_user
    puts "\n\nACHTUNG\n\n"
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.login} was successfully updated."
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
