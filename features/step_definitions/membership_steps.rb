
Given /^I have no memberships$/ do
  @user.memberships.destroy_all
end

Given /^I have the following memberships:$/ do |table|
  table.hashes.each do |hash|
    hash[:user_id] = @user.id
    Membership.create!(hash)
  end
end


Then /^I should have ([0-9]+) memberships$/ do |count|
  @user.memberships.count.should == count.to_i
end
