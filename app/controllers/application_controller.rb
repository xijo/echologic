# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Catch access denied exception in the whole application and handle it.
  rescue_from 'Acl9::AccessDenied', :with => :access_denied

  # Initializes translate_routes
  before_filter :set_locale

  # Set locale to the best fitting one
  def set_locale
    available = %w{en de}
    I18n.locale = params[:locale] || request.compatible_language_from(available)
  end

  # Authlogic authentification filters
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  # Set notice from the given i18n string.
  def set_notice(i18n)
    flash[:notice] = I18n.t(i18n)
  end


  # GENERIC AJAX METHODS SECTION

  # Get formatted error string from error partial for a given object, then show
  # it on the page object as an error message.
  def show_error_messages(object)
    render :update do |page|
      message = render :partial => 'layouts/components/error', :locals => {:object => object}
      page << "error('#{escape_javascript(message)}');"
    end
  end

  def show_info_message(string)
    render :update do |page|
      page << "info('#{string}');"
    end
  end

  # Helper method to do simple ajax replacements without writing a new template.
  # This small methods takes much complexness from the controllers.
  def replace_container(name, content)
    render :update do |page|
      page.replace name, content
    end
  end

  # Helper method to do simple ajax replacements without writing a new template.
  # This small methods takes much complexness from the controllers.
  def replace_content(name, content)
    render :update do |page|
      page.replace_html name, content
    end
  end

  # Helper method to remove some identifier from the page.
  def remove_container(name)
    render :update do |page|
      page.remove name
    end
  end


  # PRIVATE SECTION
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
    # TODO i18n
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        respond_to do |format|
          format.html { redirect_to root_path }
        end
        return false
      end
    end

    # TODO i18n
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js do
            render :update do |page|
              page.redirect_to root_path
            end
          end
        end
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
      redirect_to root_path
    end

end
