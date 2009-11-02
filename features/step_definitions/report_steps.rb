Given /^there are no user reports$/ do
  Report.destroy_all
end

Then /^"([^\"]*)" should be reported with a reason$/ do |name|
  user = Profile.find_by_first_name(name).user
  user.reports.should_not be_empty
  user.reports.first.reason.should_not be_nil
end

