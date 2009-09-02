class ApplicationController < ActionController::Base
  def current_user_session
    UserSession.find
  end
end
