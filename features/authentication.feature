
Feature: Authentication
  In order to authenticate
  As an user
  I want to login with email and password

  # A user must be able to login and see a welcome message.
  Scenario: Successful login
    Given I am logged in as "user" with password "true"
    Then I should be on the welcome page
      And I should see "Welcome"
      And I should see "Hello User"
      
  # As an user you mustn't see the admin options, as an admin
  # these options must be available.
  
  Scenario Outline: Show admin options
    Given I am logged in as "<user>" with password "<password>"
    Then I should <action>
    
    Examples:
      | user  | password | action                  |
      | admin | true     | see the "Admin" tab     |
      | user  | true     | not see the "Admin" tab | 
