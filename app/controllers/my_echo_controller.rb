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
   
end
