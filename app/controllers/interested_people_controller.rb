class InterestedPeopleController < ApplicationController

  # GET /interested_people
  # GET /interested_people.xml
  def index
    @interested_people = InterestedPerson.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interested_people }
    end
  end

  # GET /interested_people/1
  # GET /interested_people/1.xml
  def show
    @interested_person = InterestedPerson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interested_person }
    end
  end

  # GET /interested_people/new
  # GET /interested_people/new.xml
  def new
    @interested_person = InterestedPerson.new

    respond_to do |format|
      format.html { render :template => 'interested_people/new', :layout => 'static' }
      format.xml  { render :xml => @interested_person }
    end
  end

  # GET /interested_people/1/edit
  def edit
    @interested_person = InterestedPerson.find(params[:id])
  end

  # POST /interested_people
  # POST /interested_people.xml
  def create
    @interested_person = InterestedPerson.new(params[:interested_person])

    respond_to do |format|
      if @interested_person.save
        flash[:notice] = 'InterestedPerson was successfully created.'
        format.html { redirect_to(@interested_person) }
        format.xml  { render :xml => @interested_person, :status => :created, :location => @interested_person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interested_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interested_people/1
  # PUT /interested_people/1.xml
  def update
    @interested_person = InterestedPerson.find(params[:id])

    respond_to do |format|
      if @interested_person.update_attributes(params[:interested_person])
        flash[:notice] = 'InterestedPerson was successfully updated.'
        format.html { redirect_to(@interested_person) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interested_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interested_people/1
  # DELETE /interested_people/1.xml
  def destroy
    @interested_person = InterestedPerson.find(params[:id])
    @interested_person.destroy

    respond_to do |format|
      format.html { redirect_to(interested_people_url) }
      format.xml  { head :ok }
    end
  end
end
