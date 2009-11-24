Given /^there are no questions$/ do
  Question.destroy_all
end

Then /^there should be no questions$/ do
  Question.count.should == 0
end

Then /^there should be one question$/ do
  Question.count.should == 1
end

Then /^I should see an error message$/i do
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

When /^I follow the create improvement proposal link$/ do
  # Todo: Yet we still don't know how the create improvementproposal link will once look
  When 'I follow the "Create improvement proposal" link within the "children" list'
end

Then /^the question should have one proposal$/ do
  @question.children.proposals.count.should >= 1
end

# Is it okay to give a condition in a 'Given' step?
Given /^the question has at least on proposal$/ do
  @question.children.proposals.count.should >= 1
  @proposal = @question.children.proposals.first
end

Then /^the proposal should have one improvementproposal$/ do
  @proposal.children.improvement_proposals.should >= 1
end

Then /^I should not see the create proposal link$/ do
#  Then 'I should not see the "Create proposal" link within the "children" container'
  Then 'I should not see the "Create proposal" link'
end

# i leave this pending for now, as i'm not sure if we should test the related scenario here
# see Scenario: Add a proposal to a question as a user (directly)
When /^I post some valid proposal data for "([^\"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
