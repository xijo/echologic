@profile
# As an logged in User, without having a country given in my profile
# when if fill out my profile
# the completeness value of my profile should have increased

Scenario: Update Profile to make it more complete
  Given I am logged in as "ben" with password "benrocks"
  And I have not filled out the country field
  And I know how complete my profile is
  When I go to the profile
  And I follow "edit" within "#personal_container"
  And I select "Germany" from "profile[country]"
  And I press the "Save" button within the "Personal" container
  Then my profile should be more complete

# Same like above, but i don't edit my basic profile data but add an webprofile

Scenario: Update Profile with web-profiles to make it more complete
  Given I am logged in as "ben" with password "benrocks"
  And I have no web profiles
  And I know how complete my profile is
  When I go to the profile
  And I select "Homepage" from "web_profile_sort"
  And I fill in "web_profile_location" with "http://www.homepage.com/user"
  And I press "new_web_profile_submit"
  Then my profile should be more complete

# This should also tested for organizations and concernements, but there are not tests for those at all
# and it's not scope of my work now, to implement those tests. going to file issues for it anyway.
