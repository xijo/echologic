@progress
Feature: Use connect functionality
  In order to find other users
  As an user
  I want to type in search values and see the results
  
  # Within the connect area users are able to view the
  # list of users.
  Scenario: View user list
    Given I am logged in as "user" with password "true"
    When I am on the connect page
    Then I should see the user "Joe"
      And I should see the user "User"
      And I should see the user "Ben"
      And I should see the "Search" form
  
  # Through the search mechanism they may search for
  # any key word like (first) name..
  Scenario: Find user by first name
    Given I am logged in as "user" with password "true"
    When I go to the connect page
      And I fill in "value" with "Joe"
      And I press the "Search" button
    Then I should see the "Connect" container
      And I should see the "User" container
      And I should see the user "Joe"
      And I should not see the user "Ben"
  
  # ..or email.
  Scenario: Find user by email
    Given I am logged in as "user" with password "true"
    When I go to the connect page
      And I fill in "value" with "user@echologic.org"
      And I press the "Search" button
    Then I should see the "Connect" container
      And I should see the "User" container
      And I should see the user "User"
      And I should not see the user "Joe"
      
  # If they are interested in someones user details they
  # are able to view it.
  Scenario: View user details
    Given I am logged in as "user" with password "true"
      And I am on the connect page
    When I follow the "Show" link for the user "Joe"
    Then I should see the user details of "Joe"
      And I should see the "Close" link
      
