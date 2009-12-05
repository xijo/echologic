@discuss @censor
Feature: Censor Statements within a discussion
  In order to keep discussions free from inappropriate content
  As a censor
  I want to edit statements other users created

  Background:
    Given I am logged in as "editor" with password "true"

  @wip
  Scenario: Edit a proposal
    Given there is a proposal created by a regular user
    When I go to the proposal
      And I follow "edit"
      And I fill in the following:
      | text | This was inappropriate, so I changed it. |
      And I press "Save"
    Then I should see "This was inappropriate"
    
  @wip
  Scenario: Edit an improvement proposal
