class JoinController < ApplicationController

  # GET /interested_people/new
  # GET /interested_people/new.xml
  def new_interested
    @interested_person = InterestedPerson.new

    respond_to do |format|
      format.html { render :partial => "join/new_interested", :layout => "static" }
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
          
        rescue
          
        end
        #format.js { render :template => "join/new_invitation" }        

        format.html
        format.js 
      else    
        format.html { render :action => "new_interested", :layout => "static" }
        format.js { render :action => "new_interested" }
      end
    end
  end
  
  def new_invitation
    puts 'hurra'
    @invited_person = InvitedPerson.new
    #@interested_person = InterestedPerson.find(flash[:id]) if flash[:id]
    @interested_person = InterestedPerson.find(:first)
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
        format.js { render :text => "fehler" }
        format.html { render :action => "new_invitation" }
      end
    end
  end

end