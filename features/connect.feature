@progress
Feature: Use connect functionality
  In order to find other users
  As an user
  I want to type in search values and see the results
  
  Scenario: View user list
    Given I am logged in as "user" with password "true"
    When I am on the connect page
    Then I should see the user "Joe"
      And I should see the user "User"
      And I should see the user "Ben"
  
  Scenario: Find user by first name
    Given I am logged in as "user" with password "true"
    When I go to the connect page
      And I fill in "value" with "Joe"
      And I press the "Search" button
    Then I should see the "Connect" container
      And I should see the "User" container
      And I should see the user "Joe"
      And I should not see the user "Ben"
      
  Scenario: Find user by email
    Given I am logged in as "user" with password "true"
    When I go to the connect page
      And I fill in "value" with "user@echologic.org"
      And I press the "Search" button
    Then I should see the "Connect" container
      And I should see the "User" container
      And I should see the user "User"
      And I should not see the user "Joe"
      
