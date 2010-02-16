
Given /^I have no concernments$/ do
  @user.concernments.destroy_all
end

Then /^I should have ([0-9]+) concernments$/ do |count|
  @user.concernments.count.should == count.to_i
end
