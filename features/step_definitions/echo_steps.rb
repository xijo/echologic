Given /^a proposal wihout echos$/ do
  @proposal = Proposal.first
  @proposal.echo_details.destroy_all
end

Then /^the proposal should have one echo$/ do
  @proposal.reload
  @proposal.echo.supporter_count.should >= 1
end

Then /^the proposal should have one visitor but no echos$/ do
  @proposal.reload
  @proposal.echo.visitor_count.should >= 1
end


Given /^I gave an echo already to a proposal$/ do
  @proposal = Proposal.first
  @proposal.echo_details.destroy_all
  @user.supported!(@proposal)
end

Then /^the proposal should have no more echo$/ do
  @proposal.reload
  @proposal.echo.supporter_count.should == 0
end
