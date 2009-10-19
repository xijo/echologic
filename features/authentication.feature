# some comment.
Feature: Authentication

  Scenario: Successful login
    Given I am logged in as "user" with password "true"
    Then I should be on the welcome page
      And I should see "Welcome"
      And I should see "Hello User"
