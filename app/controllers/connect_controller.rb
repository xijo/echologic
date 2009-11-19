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
      format.html { render :template => 'connect/search' }
    end
  end

  # Return connect page with results of the search
  # method: POST
  def search

    @value = params[:value]
    @sort  = params[:sort]

    sort_string = @sort.nil?? "" : "c.sort = #{@sort} AND "

    query = <<-END
      select distinct p.*, u.email
      from
        profiles p
        LEFT JOIN `users` u ON u.id = p.user_id
        LEFT JOIN concernments c ON (u.id = c.user_id)
        LEFT JOIN tags t ON (t.id = c.tag_id)
      where
        #{sort_string}
        (
          p.first_name    like '%#{@value}%'
          or p.last_name  like '%#{@value}%'
          or p.city       like '%#{@value}%'
          or p.country    like '%#{@value}%'
          or p.about_me   like '%#{@value}%'
          or p.motivation like '%#{@value}%'
          or u.email      like '%#{@value}%'
        )
      order by p.first_name asc;
    END

    @profiles = Profile.find_by_sql(query).paginate(:page => params[:page], :per_page => 2)

    respond_to do |format|
      format.html { render :template => 'connect/search' }
      format.js
    end
  end

end
