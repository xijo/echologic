@web_profiles @0.2
Feature: Manage web profiles
  In order to set web profiles
  As an user
  I want to create and manage web profiles

  # A logged in user have to be able to see his web profiles
  # at the profile.

  Scenario Outline: View web profile list
    Given I am logged in as "user" with password "true"
      And I have the following web profiles:
        | sort   | location   |
        | <sort> | <location> |
    When I go to the profile
    Then I should see "<location>"
      And I should have 3 web profiles
    
    Examples:
      | sort     | location                    |
      | twitter  | http://www.twitter.com/user |
      | blog     | http://www.blog.com         |
      | homepage | http://www.homepage.com     |
  # When a new web profile is added it should be shown on
  # the users profile page.
  
  Scenario: Add new web profile
    Given I am logged in as "user" with password "true"
      And I have no web profiles
    When I go to the profile
      And I select "Homepage" from "web_profile_sort"
      And I fill in "web_profile_location" with "http://www.homepage.com/user"
      And I press "new_web_profile_submit"
    Then I should see "http://www.homepage.com/user"
      And I should have 1 web profiles
