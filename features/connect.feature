@progress
Feature: Use connect functionality
  In order to find other users
  As an user
  I want to type in search values and see the results
  
  
  Scenario: Find user by name
    Given I am logged in as "user" with password "true"
    When I go to the connect page
      And I fill in "value" with "Joe"
      And I press the "Search" button
    Then I should see the "Connect" container
      And I should see "Joe"
