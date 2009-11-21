class ConnectController < ApplicationController

  before_filter :require_user

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

    @profiles = @profiles.paginate(:page => @page, :per_page => 3)

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
        LEFT JOIN `users` u      ON u.id = p.user_id
        LEFT JOIN memberships m  ON u.id = m.user_id
        LEFT JOIN concernments c ON (u.id = c.user_id)
        LEFT JOIN tags t         ON (t.id = c.tag_id)
      where
        #{sort_string}
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
      order by p.first_name asc;
    END

    profiles = Profile.find_by_sql(query)#.paginate(:page => params[:page], :per_page => 6)

  end

end
