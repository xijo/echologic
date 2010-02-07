@connect @0.3
Feature: Use connect functionality
  In order to find other users
  As an user
  I want to type in search values and see the results

  # Within the connect area users are able to view the
  # list of users.

  Scenario: View user list
    Given I am logged in as "user" with password "true"
    And my profile is complete enough
    When I am on the connect page
    Then I should see the profile of "Joe"
      And I should see the profile of "User"
      And I should see the profile of "Ben"
      And I should see the "Search" form
  
  # As an logged in user, without a complete enough profile
  # i cannot access the connect area 


  Scenario: Try to access connect with too empty profile
    Given I am logged in as "ben" with password "benrocks"
    And my profile is not complete enough
    When I go to the connect page
    Then I should be redirected to "connect/fill_out_profile"


  # As an logged in user I am able to search for everything
  # ones profile includes:
  #  Name, Email, Concernment, Location, Motivation, About me

  Scenario Outline: Find users by different values
    Given I am logged in as "user" with password "true"
    And my profile is complete enough
    When I go to the connect page
      And I fill in "value" with "<value>"
      And I press the "Search" button
    Then I should see the profile of "<true>"
      And I should not see the profile of "<false>"

    Examples:
      | value   | true | false |
      | Energy  | Ben  | Admin |
      | Joe     | Joe  | Ben   |
      | Berlin  | Joe  | Ben   |
      | Germany | Joe  | Admin |
      | I am    | Joe  | Ben   |
      | Pantha  | Joe  | Admin |
      | user@e  | User | Joe   |

  # If they are interested in someones user details they
  # are able to view it - and to close the details.

  Scenario: View user details
    Given I am logged in as "user" with password "true"
    And my profile is complete enough
    And I am on the connect page
    When I follow the "Show" link for the profile of "Joe"
    Then I should see the profile details of "Joe"
      And I should see a "Close" link
