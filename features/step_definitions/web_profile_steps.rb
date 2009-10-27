# TODO unused atm
Given /^I have web profiles (.+)$/ do |profiles|
  profiles.split(', ').each do |profile|
    WebProfile.create!(:location => profile, :sort => profile, :user_id => current_user_session.user)
  end
end

Given /^I have the following web profiles:$/ do |table|
  table.hashes.each do |hash|
    hash[:user_id] = @user.id
    WebProfile.create!(hash)
  end
end

# TODO unused atm
When /^I create the web profile: (.*)$/ do |params|
  sort, location = params.split(', ')
  fill_in('web_profile_location', :with => location)
  click_button('new_web_profile_submit')
end

# Check count of web profiles.
Then /^I should have ([0-9]+) web profiles$/ do |count|
  @user.web_profiles.count.should == count.to_i
end

# Remove all web profiles.
Given /^I have no web profiles$/ do
  @user.web_profiles.destroy_all
end

