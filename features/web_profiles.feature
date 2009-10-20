Feature: Manage web profiles
  In order to set web profiles
  As an user
  I want to create and manage web profiles

  Scenario: Web profiles list
    Given I am logged in as "user" with password "true"
    When I go to the profile
    Then I should see "Profile"
      And I should see "twitter"
      And I should see "blog"
      And I should not see "homepage"

  @wip
  Scenario: Add new web profile
    Given I am logged in as "user" with password "true"
      And I have no web profiles
    When I go to the profile
      And I select "Homepage" from "web_profile_sort"
      And I fill in "web_profile_location" with "http://www.homepage.com/user"
      And I press "new_web_profile_submit"
    Then I should see "http://www.homepage.com/user"
      And I should have 1 web profiles
