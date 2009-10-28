Then /^I should see the user "([^\"]*)"$/ do |name|
  user = User.find_by_first_name(name)
  response.should contain(user.full_name)
end

Then /^I should not see the user "([^\"]*)"$/ do |name|
  user = User.find_by_first_name(name)
  response.should_not contain(user.full_name)
end

When /^I follow the "([^\"]*)" link for the user "([^\"]*)"$/ do |link, user|
  user = User.find_by_first_name(user)
  within("#user_#{user.id}") do
    click_link "#{link.downcase!}_link"
  end  
end

Then /^I should see the user details of "([^\"]*)"$/ do |user|
  user = User.find_by_first_name(user)
#  Then (I should see "#{user.motivation}" within "#user_details_container")
  within("#user_details_container") do |content|
    content.should contain(user.motivation)
  end
end

