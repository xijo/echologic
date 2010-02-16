@concernments @0.2
Feature: Manage Concernments
  In order to setup my profile data
  As an user
  I want to create and manage my concernments
  
  # Users may add memberships through the form at the profile page.
  
  Scenario: Add new concernments
    Given I am logged in as "user" with password "true"
      And I have no concernments
    When I go to the profile
      And I fill in the following:
        | tag_0_id | Dirty Water |
      And I press "add_tag_0"
    Then I should see "Dirty Water"
      And I should have 1 concernments
  
