Feature: edit accounts

  As a user
  So that I can change myMood account
  I want to edit my account


Background: users are in the database

  Given the following users exist:
  | phone_number | name | password  | email |
  | 222-222-2222 | Bob  | pass12345 | b@b.com |

  And I am on the myMood home page

Scenario: User changes account password
  When I fill in "user_phone_number" with "222-222-2222"
  When I fill in "user_password" with "pass12345"
  And I press "Sign in"
  Then I should be on the user index
  When I follow "Settings"
  And I fill in "user_password" with "newpass123"
  And I fill in "user_password_confirmation" with "newpass123"
  And I fill in "user_current_password" with "pass12345"
  And I press "Save"
  Then I should see "You updated your account successfully"
  And I should be on the user index
