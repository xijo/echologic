Feature: Discuss
  In order to have a proper discussion
  As a user
  I want to create questions and add proposals and add improvementproposals

  # fixtures needed:
  # user 'editor' pw 'true' -> is_editor
  
  Scenario: Create a valid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
    When I go to create a question
      # should do as above but automatically through a better step definition
#      And I post some valid question data
      And I fill in the following:
        | title | Is this a Question?   |
        | text  | Blablabla bla bla bla |
      And I press the "Save" button
    Then I should see a "question created" message
     And there should be one question

  Scenario: Add a proposal to a question as an editor (from ui)
    Given I am logged in as "editor" with password "true"
      And there is the first question
      And the question has no proposals
    # Todo: Maybe we should start navigating from the main question overview
    When I go to the question
      And I follow the create proposal link
      And I fill in the following:
        | title | a proposal to propose some proposeworthy proposal data |
        | text  | nothing to propose yet...                              |
    Then I should see a "proposal created" message
      And the question should have one proposal

  # Todo - this only checks validations from a ui-perspective, and not each individual validation
  Scenario: Create an invalid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
    When I go to create a question
      And I fill in the following:
        | text | Blablabla bla bla bla |
    # Todo: Maybe we should check the content of the error box as well
    Then I should see an error message
  
  Scenario: Add an Improvement Proposal to a Proposal
    Given I am logged in as "user" with password "true"
      And there is the first question
      And the question has at least on proposal
    When I go to the questions first proposal
      And I follow the create improvement proposal link
      # Todo: How does the plain data for an improvement proposal differ from valid data for a proposal
      And I fill in the following:
        | title | Improving the unimprovable                                    |
        | text  | blubb (oh, and of cause a lot of foo and a little bit of (mars-)bar) |
    Then I should see a "improvementproposal created" message
      And the proposal should have one improvementproposal

  # Todo:
  # * view a question / proposal
  # ** this is basically covered through the above tests, but we could need to check more detailed what the user will see
   
  ###
  ### The following tests need to be changed as soon as we are more clear about how to deal with permissions for questions
  ###

  Scenario: Create a valid question as a user
    Given there are no questions
     And I am logged in as "user" with password "true"
    When I go to create a question
#      And I post some valid question data
    And I fill in the following:
        | title | Is this a Question?   |
        | text  | Blablabla bla bla bla |
    And I press the "Save" button
    Then I should see a "permission denied" error message
      And there should be no questions

  Scenario: Add a proposal to a question as a user (from ui)
    Given I am logged in as "user" with password "true"
    # Todo: Maybe we should start navigating from the main question overview
    When I go to the first question
    Then I should not see the create proposal link
  
  # Todo: Maybe this should be better checked somewhere else
  Scenario: Add a proposal to a question as a user (directly)
    Given I am logged in as "user" with password "true"
    When I post some valid proposal data for "first-question"
    Then I should see a "permission denied" error message
