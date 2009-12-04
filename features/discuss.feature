@discuss @user
Feature: Take Part on a discussion
  In order to take part on a discussion
  As a user
  I want to give different kind of statements on questions

  Scenario: Open a question
  
  Scenario: Add a proposal to a question
   Given I am logged in as "user" with password "true"
      And there is the first question
      And the question has no proposals
      And I am on the Discuss Index
    When I follow "EchonomyJAM"
      And I choose the first Question
      And I follow "Create a new Proposal"
      And I fill in the following:
        | title | a proposal to propose some proposeworthy proposal data |
        | text  | nothing to propose yet...                              |
      And I press "Save Button"
    Then I should see "a proposal to propose some"
      And the question should have one proposal

  @wip
  Scenario: Add an Improvement Proposal to a Proposal
    Given I am logged in as "user" with password "true"
      And there is the first question
      And the question has at least on proposal
    When I go to the questions first proposal
      Then I should see "Create a new Improvement Proposal"
#     And I follow "Create a new Improvement Proposal"
      # Todo: How does the plain data for an improvement proposal differ from valid data for a proposal
#     And I fill in the following:
#      | title | Improving the unimprovable                                           |
#      | text  | blubb (oh, and of cause a lot of foo and a little bit of (mars-)bar) |
#     And I press the "Save" button
#   Then I should see "Improving the unimprovable"
#     And I should see "blubb"
#     And the proposal should have one improvement proposal

  @wip
  Scenario: Edit a proposal i created
