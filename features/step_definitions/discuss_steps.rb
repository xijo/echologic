Given /^there are no questions$/ do
  Question.destroy_all
end

Then /^there should be no questions$/ do
  Question.count.should == 0
end

Then /^there should be one question$/ do
  Question.count.should == 1
end

When /^I choose the first Question$/ do 
  response.should have_selector("a.question_link") do |selector|
    @question = Question.find(URI.parse(selector.first['href']).path.match(/\d+/)[0].to_i)
    visit selector.first['href']
  end
end

Then /^I should see an error message$/i do
  pending
  Then "I should see a \"error box\""
end

Given /^there is the first question$/i do 
  @question = Question.first
end

Given /^there is a question "([^\"]*)"$/ do |id| # not in use right now
  @question = Question.find(id)
end

Given /^the question has no proposals$/ do
  @question.children.proposals.destroy_all
end

When /^I follow the create proposal link$/ do
  # Todo: Yet we still don't know how the create proposal link will once look
  When 'I follow the "Create proposal" link within the "children" list'
end

Then /^the question should have one proposal$/ do
  @question.reload
  @question.children.proposals.count.should >= 1
end

# Is it okay to give a condition in a 'Given' step?
Given /^the question has at least on proposal$/ do
  @question.reload
  @question.children.proposals.count.should >= 1
  @proposal = @question.children.proposals.first
end

Then /^the proposal should have one improvement proposal$/ do
  @proposal.reload
  @proposal.children.improvement_proposals.count.should >= 1
end

Then /^I should not see the create proposal link$/ do
#  Then 'I should not see the "Create proposal" link within the "children" container'
  Then 'I should not see the "Create proposal" link'
end

Given /^a "([^\"]*)" question in "([^\"]*)"$/ do |state, category|
  case state
    when "new"
      state = 0
    when "published"
      state = 1
  end
  @category = Tag.find_by_value(category)
  @question = Question.new(:state => state, :category => @category, :creator => @user)
  @question.create_document(:title => "Am I a new statement?", :text => "I wonder what i really am! Maybe a statement? Or even a question?", :author => @user)
  @question.save!
end

Then /^the question should be published$/ do
  @question.reload
  @question.state.should == 1
end

Then /^I should see the questions title$/ do
  Then 'I should see "'+@question.title+'"'
end

Given /^there is a proposal I have created$/ do
  @proposal = Proposal.find_by_creator_id(@user.id)
end

Then /^the questions title should be "([^\"]*)"$/ do |title|
  @question.document.title.should == title
end
