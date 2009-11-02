@reports @0.3
Feature: Report unseemly behaving users
  In order to 
  As an user
  I want to report the suspects to an administrator
  And
  As an administator
  I want to delete or modify these suspects
  
  
  # Report a user
  Scenario: Send user report
    Given I am logged in as "Joe" with password "true"
      And there are no user reports
    When I am on the connect page
      And I follow the "Report" link for the profile of "Joe"
      And I fill in "Report reason" with "User has red hair."
      And I press the "Report" button
    Then I should see "Thank you for your message. An administrator was notified."
      And "Joe" should be reported with a reason
      
  # 
  @wip
  Scenario: Users cannot see reports
    Given I am logged in as "User" with password "true"
    Then I should not be able to access the reports page
    
    
  
