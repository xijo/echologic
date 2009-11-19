require File.join(File.dirname(__FILE__), "/spec_helper" )

describe Statement do
  
  context "creating a question" do
    before(:each) do 
      @user = User.find_by_email("editor@echologic.org")
      @document = StatementDocument.new(:title => 'Is it a question?', :text => 'The question is, is this a question?') 
      @statement = Question.new(:creator => @user, :document =>  @document)
    end
    
    it "should be valid" do
      @statement.should be_valid
    end
    
    it "should be of Type 'Question'" do
      @statement.class.name.should == "Question"  
    end
    
    it "should have an creator" do
      @statement.creator.should_not be_nil
    end
    
    it "should not save without a creator" do
      @statement.creator = nil
      @statement.should_not be_valid
    end
    
    it "should not save without a document" do
      @statement.document = nil
      @statement.should_not be_valid
    end
    
    it "should not save without a valid parent (Question or none)" do
      @statement.parent = Question.first
      @statement.should be_valid
      @statement.parent = Proposal.first
      @statement.should_not be_valid
      @statement.parent = ImprovementProposal.first
      @statement.should_not be_valid
    end
    
    it "should not save without a root when it has a parent" do
      @statement.root_id = nil
      @statement.parent = nil
      @statement.should be_valid
      @statement.parent = Question.first
      @statement.should_not be_valid
      @statement.root_id_ = Question.first.id
      @statement.should be_valid
    end
    
  end
  
  context "creating a proposal for a question" do
    before(:each) do
      @user = User.find_by_email("editor@echologic.org")
      @document = StatementDocument.new(:title => 'A proposal', :text => 'For every question, theres a proposal!') 
      @statement = Proposal.new(:parent => Question.first, :creator => @user, :document => @document)
    end
    
    it "should be valid" do
      @statement.should be_valid
    end
    
    it "should be of type 'Proposal'" do
      @statement.class.name.should == 'Proposal'
    end
    
    it "should not save without a valid parent (a question)" do
      @statement.parent = nil
      @statement.should_not be_valid
      @statement.parent = Proposal.first
      @statement.should_not be_valid
    end
  end
  
  context "creating an improvementproposal for a proposal" do
    before(:each) do
      @user = User.find_by_email("editor@echologic.org")
      @document = StatementDocument.new(:title => 'Improvement', :text => 'I am a proposal to improve this proposal!!')
      @statement = ImprovementProposal.new(:parent => Proposal.first, :creator => @user, :document => @document)
    end
   
    it "should be valid" do
      @statement.should be_valid
    end
    
    it "should be of type 'ImprovementProposal" do
      @statement.class.name.should == 'ImprovementProposal'
    end
    
    it "should not save without a valid parent (a proposal)" do
      @statement.parent = nil
      @statement.should_not be_valid
      @statement.parent = ImprovementProposal.first
      @statement.should_not be_valid
    end
    
  end
  
  context "loading a statement" do
    before(:each) do
      @question = Question.first
    end
    
    it "should have an User associated as a creator" do
      @question.creator.class.name.should == 'User'
    end
    
    it "should have a StatementDocument associated as a document" do
      @question.document.class.name.should == 'StatementDocument'
    end
  end  
  
  context "loading a question that already has proposals" do
    before(:each) do
      # we know that the first Question has two proposals already
      @question = Question.first
    end
    
    it "should have proposals accessible through .children.proposals" do
      @question.children.proposals.any?.should be_true
    end
  end
  
end
