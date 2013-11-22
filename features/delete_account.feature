Feature: delete accounts

  As a user
  So that I can stop using myMood
  I want to delete my account


Background: users are in the database

  Given the following users exist:
  | phone_number | name | password  | email |
  | 222-222-2222 | Bob  | pass12345 | b@b.com |

  And I am on the myMood home page

Scenario: User changes account password
  # Sign in
  When I fill in "user_phone_number" with "222-222-2222"
  When I fill in "user_password" with "pass12345"
  And I press "Sign in"
  Then I should be on the user index
  When I follow "Settings"
  # Cancel
  And I press "Cancel my account"
  Then I should be on the myMood home page
  And I should see "Bye! Your account was successfully cancelled. We hope to see you again soon."
  # Try to log in again
  When I fill in "user_phone_number" with "222-222-2222"
  When I fill in "user_password" with "pass12345"
  And I press "Sign in"
  Then I should see "Invalid email or password"
