class ConnectController < ApplicationController

  # GET /connect
  def show
    respond_to do |format|
      format.html
    end
  end
  
  # POST search
  def search
    @users = User.find(:all,
        :conditions => ['email like ? or name like ? or prename like ?', filter, filter, filter],
        :limit => 30)
    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end

end
