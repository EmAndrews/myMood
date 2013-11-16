Feature: Log out

  As a user
  So that other people can't mess with my account
  I want to sign out of myMood

Background:

  Given the following users exist:
  | phone_number | name | password  | email   |
  | 222-222-2222 | Bob  | pass12345 | a@a.com |

  And I am on the myMood home page
  And I fill in "user_phone_number" with "222-222-2222"
  And I fill in "user_password" with "pass12345"
  And I press "Sign in"
  Then I should be on the user index

Scenario: User logs out of myMood
  When I follow "Logout"
  Then I should be on the myMood home page
