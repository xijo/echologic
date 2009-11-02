@reports @0.3
Feature: Report unseemly behaving users
  In order to 
  As an user
  I want to report the suspects to an administrator
  And
  As an administator
  I want to delete or modify these suspects
  
  
  # As an user you are able to create a user report.
  Scenario: Send user report
    Given I am logged in as "Joe" with password "true"
      And there are no user reports
    When I am on the connect page
      And I follow the "Report" link for the profile of "Joe"
      And I fill in "Report reason" with "User has red hair."
      And I press the "Report" button
    Then I should see "Thank you for your message. An administrator was notified."
      And "Joe" should be reported with a reason
      
  # With user access you can't view reports.
  Scenario: Users cannot see reports
    Given I am logged in as "User" with password "true"
    Then I should not be able to access the reports page
    
  # As an admin you can see all new and done user reports.
  Scenario: View user reports
    Given I am logged in as "Admin" with password "true"
    When I go to the reports page
    Then I should see the "Active reports" container
      And I should see the "Done reports" container
      And I should see 1 active report for "Joe"
      And I should see 1 done report for "Joe"
      And I should see 2 reports
    
  # As an administrator I have the opportunity to change the status
  # of an user report.
  @wip
  Scenario: Change report status and decision
    Given I am logged in as "Admin" with password "true"
    When I go to the reports page
      And I follow the "Edit" link
    
  
