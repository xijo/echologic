class ConnectController < ApplicationController

  before_filter :require_user

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
  
    @value = params[:value]
  
    search = Profile.search
    
    search.first_name_like = @value
    search.last_name_like  = @value
    #search.motivation_like = params[:value]
    #search.about_me_like   = params[:value]
    #search.city_like       = params[:value]
    #search.country_like    = params[:value]
    #search.user_email_like = params[:value]
    
    #search.user_tags_value_like = params[:value]
    
    @profiles = search.all

  
    #filter = params[:value]
    @profiles = Profile.first_name_or_last_name_like(@value).paginate(:page => params[:page])
    
  #  @profiles += Profile.motivation_or_about_me_or_city_or_country_like(filter)
    
  #  @profiles += Profile.user_tags_value_like(filter)
    
   # @profiles += Profile.user_email_like(filter)
    
  #  @profiles.uniq!
    
    #@profiles = Profile.paginate :page => params[:page]
    
    respond_to do |format|
      format.html { render :template => 'connect/profiles' }
      format.js 
    end
  end

end
