
Feature: Profile settings
  In order to setup my profile
  As an user
  I want to insert and update my user data
  
  Scenario: Edit basic information
    Given I am logged in as "user" with password "true"
    When I go to the profile
      And I follow the "Edit" link within the "Personal" container
      And I fill in the following:
        | user_name       | Name           |
        | user_city       | Berlin         |
        | user_country    | Germany        |
        | user_about_me   | This is me.    |
        | user_motivation | My motivation. |
      And I press the "Save" button within the "Personal" container
    Then I should see "Berlin"
      And I should see "Germany"
      And I should see "This is me."
      And I should see "My motivation."
  
  Scenario: Picture upload
    Given I am logged in as "user" with password "true"
    When I go to the profile
      And I follow the "Upload" link within the "Picture" container
    Then I should see "Picture upload"
      And I should see "Send"
      And I should see "Close"
