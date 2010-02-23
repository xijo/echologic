@discuss @editor
Feature: Start a discussion
  In order to start a proper discussion
  As an editor
  I want to create questions and add proposals to it

  # Firstly do it unpublished...
  @ok
  Scenario: Create a valid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
      And I am on the Discuss Index
    When I follow "echonomy JAM"
      And I follow "Open a new debate"
      And I fill in the following:
        | question_document_title | Is this a Question?   |
        | question_document_text  | Blablabla bla bla bla |
      And I select "New" from "state"
      And I press "Save"
    Then I should see "Is this a Question?"
     And there should be one question

  @ok
  Scenario: Publish a question i created as an editor
    Given I am logged in as "editor" with password "true"
      And a "New" question in "echonomyJAM"
      And I am on the Discuss Index
    When I go to the question
      And I follow "edit" within "#summary"
      And I select "Published" from "state"
      And I press "Save"
    Then the question should be published

  @ok
  Scenario: Create an invalid question as an editor
    Given there are no questions
      And I am logged in as "editor" with password "true"
    When I go to create a question
      And I fill in the following:
        | question_document_text | Blablabla bla bla bla |
      And I press "Save"
    # Todo: Maybe we should check the content of the error box as well
    Then there should be no questions
      And I should see an error message

  @ok
  Scenario: Add a proposal to a question as an editor (from ui)
    Given I am logged in as "editor" with password "true"
      And there is the first question
      And the question has no proposals
      And I am on the Discuss Index
    When I follow localized "discuss.topics.echonomy_jam.name"
      And I choose the first Question
      And I follow "Enter a new position"
      And I fill in the following:
        | proposal_document_title | a proposal to propose some proposeworthy proposal data |
        | proposal_document_text | nothing to propose yet...                              |
      And I press "Save"
    Then I should see "a proposal to propose some"
      And the question should have one proposal
      
  @allow-rescue
  Scenario: Create a valid question as a user
    Given there are no questions
     And I am logged in as "user" with password "true"
    When I go to create a question
    Then I should see an error message
