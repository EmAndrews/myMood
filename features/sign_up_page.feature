Feature: Viewing sign up page

  As a user
  So that I can use myMood
  I want to view the signup page.
 
Scenario: Viewing sign up page
        Given I am on the sign up page
        Then I should see "Phone number"
        And I should see "Password"
        And I should see "Password confirmation"
