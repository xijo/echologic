@discuss
Feature: Discuss
  In order to have a proper discussion
  As a user
  I want to create questions and add proposals and add improvementproposals

  # fixtures needed:
  # user 'editor' pw 'true' -> is_editor

  Scenario: Create a valid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
      And I am on the Discuss Index
    When I follow "EchonomyJAM"
      And I follow "Create a new Question"
      And I fill in the following:
        | title | Is this a Question?   |
        | text  | Blablabla bla bla bla |
      And I press the "Save" button
    Then I should see "Is this a Question?"
     And there should be one question

  Scenario: Add a proposal to a question as an editor (from ui)
    Given I am logged in as "editor" with password "true"
      And there is the first question
      And the question has no proposals
      And I am on the Discuss Index
    When I follow "EchonomyJAM"
      And I choose the first Question
      And I follow "Create a new Proposal"
      And I fill in the following:
        | title | a proposal to propose some proposeworthy proposal data |
        | text  | nothing to propose yet...                              |
      And I press the "Save" button
    Then I should see "a proposal to propose some"
      And the question should have one proposal

  # TODO:  This does the same as above, only as a user instead of an editor
  Scenario: Add a proposal to a question as a user (from ui)
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
      And I press the "Save" button
    Then I should see "a proposal to propose some"
      And the question should have one proposal

  # Todo - this only checks validations from a ui-perspective, and not each individual validation
  Scenario: Create an invalid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
    When I go to create a question
      And I fill in the following:
        | text | Blablabla bla bla bla |
      And I press the "Save" button
    # Todo: Maybe we should check the content of the error box as well
    Then there should be no questions
      And I should see an error message

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

  # Todo:
  # * view a question / proposal
  # ** this is basically covered through the above tests, but we could need to check more detailed what the user will see

  ###
  ### The following tests need to be changed as soon as we are more clear about how to deal with permissions for questions
  ###

  @allow-rescue
  Scenario: Create a valid question as a user
    Given there are no questions
     And I am logged in as "user" with password "true"
    When I go to create a question
    Then I should see an error message
#    And I fill in the following:
#      | title | Is this a Question?   |
#      | text  | Blablabla bla bla bla |
#    And I press the "Save" button
#    Then there should be no questions
#      And I should see a "permission denied" error message


  Scenario: Add a proposal to a question as a user (directly)
    Given I am logged in as "user" with password "true"
    When I post some valid proposal data for "first-question"
    Then I should see an error message
