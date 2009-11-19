Given /^a proposal wihout echos$/ do
  @proposal = Proposal.first
  @proposal.user_echos.destroy_all
end

Then /^the proposal should have one echo$/ do
  @proposal.echo.supported_count.should >= 1
end

Given /^I gave an echo already to a proposal$/ do
  @proposal = Proposal.first
  @proposal.user_echos.destroy_all
  @echo = UserEcho.new(:user => @user, :visited=>true, :supported=>true)
  @echo.save!
end

Then /^the proposal should have no more echo$/ do
  @proposal.echo.supported_count.should == 0
end
