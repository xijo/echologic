@memberships @0.2
Feature: Manage memberships
  In order to setup my profile data
  As an user
  I want to create and manage my memberships
  
  # Users may add memberships through the form at the profile page.
  
  Scenario: Add new membership
    Given I am logged in as "user" with password "true"
      And I have no memberships
    When I go to the profile
      And I fill in the following:
        | membership_organisation | Greenpeace |
        | membership_position     | Activist   |
      And I press the "Create" button within the "Membership" container
    Then I should see "Greenpeace"
      And I should see "Activist"
      And I should have 1 memberships
  
