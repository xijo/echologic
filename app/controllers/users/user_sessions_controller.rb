class Users::UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    respond_to do |format|
      format.html
    end
  end

  # TODO use redirect back or default! see application controller!
  def create
#    @user_session = UserSession.new(params[:user_session])
    @user_session = UserSession.new({:password => params[:user_session][:password], :login => 'xijo'})
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to profile_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to echologic_path
  end
end