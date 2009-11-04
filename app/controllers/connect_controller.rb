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
    search.city_like       = params[:value]
    search.country_like    = params[:value]
    search.motivation_like = params[:value]
    search.about_me_like   = params[:value]
    search.user_email_like = params[:value]

    search.user_tags_value_equals = params[:value]

    # Very prototypy solution to get the right data. Problem is, that
    # searchlogic doesn't provide OR searches yet.

    conditions = search.scope(:find)[:conditions].gsub(' AND ', ' OR ')

    joins = "INNER JOIN `users` ON `users`.id = `profiles`.user_id INNER JOIN `concernments` ON (`users`.`id` = `concernments`.`user_id`)  INNER JOIN `tags` ON (`tags`.`id` = `concernments`.`tag_id`)  INNER JOIN `users` users_profiles ON `users_profiles`.id = `profiles`.user_id".gsub('INNER', 'LEFT')

    @profiles = Profile.find( :all,
                              :joins => joins,
                              :conditions => conditions,
                              :readonly => true,
                              :select => 'DISTINCT profiles.*',
                              :order => 'first_name'
                              ).paginate(:page => params[:page], :per_page => 2)

    respond_to do |format|
      format.html { render :template => 'connect/profiles' }
      format.js
    end
  end

end
