class Users::UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :login_with_cas]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    respond_to do |format|
      format.html
    end
  end

  # TODO use redirect back or default! see application controller!
  def create
    @user_session = UserSession.new(params[:user_session])
    respond_to do |wants|
      if @user_session.save
        flash[:notice] = I18n.t('users.user_sessions.messages.login_success')
        wants.html { redirect_to welcome_path }
      else
        flash[:error] = I18n.t('users.user_sessions.messages.login_failed')
        wants.html { redirect_to root_path }
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = I18n.t('users.user_sessions.messages.logout_success')
    CASClient::Frameworks::Rails::GatewayFilter.logout(self, root_url)
#    redirect_to root_path
  end
end
