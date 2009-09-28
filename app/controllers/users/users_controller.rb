class Users::UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]


  access_control do
    allow logged_in, :to => [:show, :index, :filter]
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
    @user = User.find(params[:id])
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

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User was successfully updated."
        format.html { redirect_to(users_path) }
      else
        format.html { render :action => "edit" }
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

  # Filter the users list.
  def filter
    @users = User.find(:all)
    filter = "%#{params[:filter_text]}%"

    @users = User.find(:all,
      :conditions => ['email like ? or name like ? or prename like ?', filter, filter, filter],
      :limit => 30)
    
    respond_to do |format|
      format.js { render :partial => 'list' }
    end
#    render :update do |page|
#      page.replace_html 'userList', :partial => 'list'
#    end
  end


end
