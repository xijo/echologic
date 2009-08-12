class InvitedPeopleController < ApplicationController
  # GET /invited_people
  # GET /invited_people.xml
  def index
    @invited_people = InvitedPerson.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invited_people }
    end
  end

  # GET /invited_people/1
  # GET /invited_people/1.xml
  def show
    @invited_person = InvitedPerson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invited_person }
    end
  end

  # GET /invited_people/new
  # GET /invited_people/new.xml
  def new
    @invited_person = InvitedPerson.new

    respond_to do |format|
      format.html { render :partial => "new", :layout => "static" } # new.html.erb
      format.xml  { render :xml => @invited_person }
    end
  end

  # GET /invited_people/1/edit
  def edit
    @invited_person = InvitedPerson.find(params[:id])
  end

  # POST /invited_people
  # POST /invited_people.xml
  def create
    @invited_person = InvitedPerson.new(params[:invited_person])

    respond_to do |format|
      if @invited_person.save
        flash[:notice] = 'InvitedPerson was successfully created.'
        format.html { redirect_to(@invited_person) }
        format.xml  { render :xml => @invited_person, :status => :created, :location => @invited_person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invited_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invited_people/1
  # PUT /invited_people/1.xml
  def update
    @invited_person = InvitedPerson.find(params[:id])

    respond_to do |format|
      if @invited_person.update_attributes(params[:invited_person])
        flash[:notice] = 'InvitedPerson was successfully updated.'
        format.html { redirect_to(@invited_person) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invited_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invited_people/1
  # DELETE /invited_people/1.xml
  def destroy
    @invited_person = InvitedPerson.find(params[:id])
    @invited_person.destroy

    respond_to do |format|
      format.html { redirect_to(invited_people_url) }
      format.xml  { head :ok }
    end
  end
end
