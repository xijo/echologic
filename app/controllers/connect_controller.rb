class ConnectController < ApplicationController

  before_filter :require_user
  
  # if the users profile is not fullfilled, we display a message and won't let him into the other users profiles
  before_filter :check_completeness, :except => 'fill_out_profile'

  # Show the connect page
  # method: GET
  def show
    @value    = params[:value] || ""
    @sort     = params[:sort]  || ""
    @page     = params[:page]  || 1
    @profiles = search(@sort, @value.split(' ').first)

    if @value.split(' ').size > 1
       for value in @value.split(' ')[1..-1] do
        @profiles &= search(@sort, value)
      end
    end

    @profiles = @profiles.paginate(:page => @page, :per_page => 6)
    
    # decide which rjs template to render, based on if a search query was entered
    # atm we don't want to toggle profile details when we paginate, but when we search
    # TODO: if search and paginate logic drift more apart, consider seperate controller actions
    
    respond_to do |format|
      format.html { render :template => 'connect/search' }
      format.js   { render :template => 'connect/search' }     
    end
  end

  # Render the roadmap template.
  # method: GET
  def roadmap
    respond_to do |format|
      format.html # roadmap.html.erb
    end
  end

  # Return connect page with results of the search
  # method: POST
  def search(sort, value)

    sort_string = sort.blank?? "" : "c.sort = #{sort} AND "

    query = <<-END
      select distinct p.*, u.email
      from
        profiles p
        LEFT JOIN users u        ON u.id = p.user_id
        LEFT JOIN memberships m  ON u.id = m.user_id
        LEFT JOIN concernments c ON (u.id = c.user_id)
        LEFT JOIN tags t         ON (t.id = c.tag_id)
      where
        #{sort_string} 
        u.active = 1 AND
        (
          p.first_name    like '%#{value}%'
          or p.last_name  like '%#{value}%'
          or p.city       like '%#{value}%'
          or p.country    like '%#{value}%'
          or p.about_me   like '%#{value}%'
          or p.motivation like '%#{value}%'
          or u.email      like '%#{value}%'
          or t.value      like '%#{value}%'
          or m.position   like '%#{value}%'
          or m.organisation like '%#{value}%'
        )
      order by CASE WHEN p.last_name IS NULL OR p.last_name="" THEN 1 ELSE 0 END, p.last_name, p.first_name, u.id asc;
    END

    profiles = Profile.find_by_sql(query)
    
  end
  
  # checks wether the users profile is complete enough to view other users profiles
  def check_completeness
    # something like...
    # maybe trigger ajax, but i think redirecting is better
    redirect_to :action => 'fill_out_profile' if current_user.profile.completeness.nil? || current_user.profile.completeness < 0.5
  end
  
  def fill_out_profile
  end

end
