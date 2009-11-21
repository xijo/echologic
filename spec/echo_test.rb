require File.join(File.dirname(__FILE__), "spec_helper" )

describe Echo do 
  context "visit a statement" do 
    before(:each) do
      @user = User.first
      @echoable = Statement.first
      @old_count = @echoable.echo.visitor_count rescue 0
      @echo_detail = @user.visited!(@echoable)
    end
    
    it "should be marked as visited" do 
      @echo_detail.visited.should be_true
    end
    
    it "should update echo's visitor count" do
      @echo_detail.echo.visitor_count.should >= @old_count
    end
    
    it "should include user in echoable's visitor list" do 
      @echoable.visitors.should include @user
    end
  end
  
  context "support a statement" do 
    before(:each) do 
      @user = User.first
      @echoable = Statement.first
      @old_count = @echoable.echo.supporter_count rescue 0
      @echo_detail = @user.supported!(@echoable)
    end
    
    it "should be marked as supported" do 
      @echo_detail.supported.should be_true
    end
    
    it "should update echo's supporter count" do 
      @echo_detail.echo.supporter_count.should >= @old_count
    end
    
    it "should include user in echoable's supporter list" do 
      @echoable.supporter.should include @user
    end
  end
end
