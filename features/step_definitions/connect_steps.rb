Then /^I should see the profile of "([^\"]*)"$/ do |name|
  profile = Profile.find_by_first_name(name)
  response.should contain(profile.full_name)
end

Then /^I should not see the profile of "([^\"]*)"$/ do |name|
  profile = Profile.find_by_first_name(name)
  response.should_not contain(profile.full_name)
end

When /^I follow the "([^\"]*)" link for the profile of "([^\"]*)"$/ do |link, user|
  profile = Profile.find_by_first_name(user)
  response.should have_selector("#profile_#{profile.id} a.#{link.downcase!}_link") do |selector|
      visit selector.first['href']
  end
end  

Then /^I should see the profile details of "([^\"]*)"$/ do |user|
  profile = Profile.find_by_first_name(user)
  #within("#profile_details_container") do |content|
    response.should contain(profile.motivation)
  #end
end

And  /^my profile is complete enough$/ do
  @user.profile.completeness.should >= 0.5
end


And  /^my profile is not complete enough$/ do
  @user.profile.completeness.should <= 0.5
end


Then /^I should be redirected to "(.*)"$/ do |url|
  response.should redirect_to(url)
end


