require File.join(File.dirname(__FILE__), "/spec_helper" )

describe StatementDocument do
  
  context "creating a document" do
    before(:each) do
      @document = StatementDocument.new(:author => User.first, :title => 'My Document', :text => "This should be a longer explanation of the document")
    end
    
    it "should be valid" do
     @document.should be_valid
    end
    
    it "should not save without an author" do
     @document.author = nil
     @document.should_not be_valid
    end
  
    it "should not save without a title" do
      @document.title = nil
      @document.should_not be_valid
    end

    it "should not save without a text" do
      @document.text = nil
      @document.should_not be_valid
    end
  end
  
  context "loading a document" do
    before(:each) do
      @document = StatementDocument.first
    end
    
    it "should have a user associated as an author" do
      @document.author.class.name.should == 'User'
    end
  end
end
