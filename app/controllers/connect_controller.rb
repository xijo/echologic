class ConnectController < ApplicationController

  # Show the connect page
  # method: GET
  def show
    respond_to do |format|
      format.html
    end
  end
  
  def profiles
    @profiles = Profile.find(:all)
    respond_to do |format|
      format.html
    end
  end
  
  # Return connect page with results of the search
  # method: POST
  def search
    filter = params[:value]
    @profiles = Profile.first_name_or_last_name_like(filter)
    
    @profiles += Profile.motivation_or_about_me_or_city_or_country_like(filter)
    
    @profiles += Profile.user_tags_value_like(filter)
    
    @profiles += Profile.user_email_like(filter)
    
    @profiles.uniq!
    
    respond_to do |format|
      format.html { render :template => 'connect/profiles' }
      format.js 
    end
  end

end
