Given /^I have not filled out the country field$/ do
  @user.profile.country = nil
  @user.profile.save!
  @user.profile.country.should be_nil
end

Then /^my profile should be more complete$/ do
  @user.profile.completeness.should >= @completeness
end

Given /^I know how complete my profile is$/ do
  @completeness = @user.profile.completeness
end
