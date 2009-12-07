@discuss @edit
Feature: Edit Statements within a discussion
  In order to keep discussions free from inappropriate content
  As an editor
  I want to edit statements other users created

  Background:

  @wip
  Scenario: Edit a proposal as an editor
    Given there is a proposal created by a regular user
      And I am logged in as "editor" with password "true"
    When I go to the proposal
      And I follow "Edit"
      And I fill in the following:
      | proposal_document_text | This was inappropriate, so I changed it. |
      And I press "Save"
    Then I should see "This was inappropriate"
    
  @wip
  Scenario: Attempt to edit a proposal as a user
    Given there is a proposal created by a regular user
      And I am logged in as "editor" with password "true"
    When I go to the proposal
    Then I should not see the "edit" link

