class MyEchoController < ApplicationController

  before_filter :require_user

  helper :profile

  access_control do
    allow logged_in
  end

  def roadmap
    respond_to do |format|
      format.html
    end
  end

  def profile
    @profile = @current_user.profile
    @user    = @current_user
    render
  end

  def welcome
    render
  end
  
  # called from connect, when the profile is not complete enough to see other peoples profile
  def fill_out_profile
  end
  
end
