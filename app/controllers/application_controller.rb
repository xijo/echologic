# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Catch access denied exception in the whole application and handle it.
  rescue_from 'Acl9::AccessDenied', :with => :access_denied

  # Initializes translate_routes
  #  before_filter :set_locale_from_url
  
  before_filter :set_locale
  
  def set_locale
    available = %w{en de}
    I18n.locale = params[:locale] || request.compatible_language_from(available)
  end

#  def default_url_options(options={})
#    logger.debug "default_url_options is passed options: #{options.inspect}\n"
#    { :locale => I18n.locale }
#  end



  # Authlogic authentification filters
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  # PRIVATE
  private

    # Return current session if one exists
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    # Returns currently logged in user
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    # TODO comment and js?
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        respond_to do |format|
          format.html { redirect_to echologic_path }
#          format.js { render :template => 'layouts/headContainer', :locals => { :menu_item => 'users/user_sessions/failed'}}
        end
        #redirect_to join_path #new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        respond_to do |format|
          format.html
          format.js
        end
        #redirect_to join_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    # If access is denied display warning and redirect to users_path
    # TODO localize access denied message
    def access_denied
      flash[:error] = 'Access denied.'
      redirect_to users_path
    end

end

