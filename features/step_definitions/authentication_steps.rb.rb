# Login process for given user and password. If user isn't in email format
# the standard mail ending will be appended.
When /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |user, password|
  user += "@echologic.org" unless user =~ /.*@.*\..{2,3}/
  visit root_url
  fill_in('user_session_email', :with => user)
  fill_in('user_session_password', :with => password)
  click_button('user_session_submit')
  @user = User.find_by_email(user)
end
