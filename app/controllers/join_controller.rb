class JoinController < ApplicationController

  # GET /interested_people/new
  # GET /interested_people/new.xml
  def new
    @interested_person = InterestedPerson.new

    respond_to do |format|
      format.html { render :partial => "new", :layout => "static" }
      format.js
    end
  end
  
  def create_interested
    @interested_person = InterestedPerson.new(params[:interested_person])
    respond_to do |format|
      if @interested_person.save
        flash[:id] = @interested_person.id
        begin
          Mailer.deliver_thank_you(@interested_person)
        rescue SocketError
          
        end
        format.js { render :template => "join/invite" }        
        format.html { redirect_to :controller => "join", :action => "invite" }
#        flash[:notice] = 'InterestedPerson was successfully created.'
#        @invited_person = InvitedPerson.new
#        format.html { render :partial => "invited_people/new", :layout => "static" }
        format.xml  { render :xml => @interested_person, :status => :created, :location => @interested_person }
      else    
        format.html { render :action => "new", :layout => "static" }
        format.js { render :action => "new" }
      end
    end
  end
  
  def invite
    @invited_person = InvitedPerson.new
    #@interested_person = (flash[:id].nil?)? InterestedPerson.find(:first) : InterestedPerson.find(flash[:id])
    @interested_person = InterestedPerson.find(flash[:id]) if flash[:id]
    respond_to do |format|
      format.html { render :partial => "invite", :layout => "static" }
      format.js
      format.xml  { render :xml => @invited_person }
    end
  end
  
  def create_invitation
    puts params.inspect

    @invited_person = InvitedPerson.new(params[:invited_person])
    respond_to do |format|
      if @invited_person.save
        begin
          Mailer.deliver_invitation(@invited_person)
        rescue
        
        end
        format.html { render :partial => 'invited_person', :locals => { :invited_person => @invited_person } }
      else
        format.js { render :text => "" }
        format.html { render :action => "invite" }
      end
    end
  end

end