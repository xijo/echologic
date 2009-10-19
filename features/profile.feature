@wip
Feature: Profile settings
  In order to setup my profile
  As an user
  I want to insert and update my user data
  
  Scenario: Edit basic information
    Given I am logged in as "user" with password "true"
    When I go to the profile
      And I follow "Edit" within "#personal"
    Then I should see "Edit My Account"
  
  Scenario: Picture upload
    Given I am logged in as "user" with password "true"
    When I go to the profile
      And I follow "Upload" within "#picture"
    Then I should see "Picture upload"
      And I should see "Send"
      And I should see "Close"
