Then /^I should see the user "([^\"]*)"$/ do |name|
  user = User.find_by_first_name(name)
  response.should contain(user.full_name)
end

Then /^I should not see the user "([^\"]*)"$/ do |name|
  user = User.find_by_first_name(name)
  response.should_not contain(user.full_name)
end

