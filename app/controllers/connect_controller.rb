class ConnectController < ApplicationController

  # Show the connect page
  # method: GET
  def show
    respond_to do |format|
      format.html
    end
  end
  
  # Return connect page with results of the search
  # method: POST
  def search
    filter = params[:value]
    @users = User.first_name_or_last_name_or_email_like(filter)
    respond_to do |format|
      format.html { render :template => 'users/users/index' }
      format.js 
    end
  end

end
