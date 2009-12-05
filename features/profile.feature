@profile @0.2
Feature: Profile settings
  In order to setup my profile
  As an user
  I want to insert and update my user data

  # A profile consists of some containers, check if
  # all of them are present.

  Scenario: View profile
    Given I am logged in as "user" with password "true"
    When I go to the profile
    Then I should see the "Personal" container
      And I should see the "profile_avatar" container
      And I should see the "Web profile" container
      And I should see the "Membership" container

  # In the profile the user should be able to update
  # its user data.

  Scenario: Edit basic information
    Given I am logged in as "user" with password "true"
    When I go to the profile
      And I follow "edit" within "#personal_container"
      And I fill in the following:
        | profile[last_name]  | Last name      |
        | profile[first_name] | First name     |
        | profile[city]       | Berlin         |
        | profile[about_me]   | This is me.    |
        | profile[motivation] | My motivation. | 
      And I select "Germany" from "profile[country]"
      And I press the "Save" button within the "Personal" container
    Then I should see "Last name"
      And I should see "First name"
      And I should see "Berlin"
      And I should see "Germany"
      And I should see "This is me."
      And I should see "My motivation."

  # The user should also be able to upload his picture.

  Scenario: Picture upload
    Given I am logged in as "user" with password "true"
    When I go to the profile
      And I follow "Change" within "#profile_avatar_container"
    Then I should see "Upload Picture"
      And I should see "Cancel"
      And I should see "Upload"

  # After all the user has to be able to change his password as well.
  # TODO: Password change ist not possible atm - when possible again, this test needs to be activated
  #Scenario: Change password
    #Given I am logged in as "user" with password "true"
    #  And I am on the profile
    #When I press the "Submit" button within the "Password" container
    #Then I should see "We have sent you an E-mail allowing you to reset your password. Please check your inbox."
