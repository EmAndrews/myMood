Feature: edit accounts

  As a user
  So that I can change myMood account
  I want to edit my account


Background: users are in the database

  Given the following users exist:
  | phone_number | name | password  | email |
  | 222-222-2222 | Bob  | pass12345 | b@b.com |

  And I am on the myMood home page
  When I fill in "user_phone_number" with "222-222-2222"
  When I fill in "user_password" with "pass12345"
  And I press "Sign in"
  And I am on the user index

Scenario: User changes account password
  When I follow "Settings"
  And I fill in "user_password" with "newpass123"
  And I fill in "user_password_confirmation" with "newpass123"
  And I fill in "user_current_password" with "pass12345"
  And I press "Save"
  Then I should see "You updated your account successfully"
  And I should be on the user index

Scenario: User unsuccessfully tries to change password
  When I follow "Settings"
  And I fill in "user_password" with "newpass123"
  And I fill in "user_password_confirmation" with "newpass12"
  And I fill in "user_current_password" with "pass12345"
  And I press "Save"
  Then I should see "Failed to update settings"
