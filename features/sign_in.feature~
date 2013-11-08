Feature: Signing in

  As a user
  So that I can use myMood
  I want to log into myMood
  
Background: users have been added to the database

  Given the following users exist:
  | phone_number | name | password | email   |
  | 123-456-7890 | Bob  | pass     | a@a.com |

	And I am on the myMood home page

Scenario: User attempts to sign in with no phone number or password
  When I fill in "Phone Number" with ""
  When I fill in "Password" with ""
  And I press "submit"
  Then I should see "Invalid phone number or password"
  
Scenario: User attempts to sign in with no phone number but correct password
  When I fill in "Phone Number" with ""
  When I fill in "Password" with "pass"
  And I press "submit"
  Then I should see "Invalid phone number or password"
  
Scenario: User attempts to sign in with a valid phone number but no password
  When I fill in "Phone Number" with "123-456-7890"
  When I fill in "Password" with ""
  And I press "submit"
  Then I should see "Invalid phone number or password"
  
Scenario: User attempts to sign in with a correct phone number and wrong password
  When I fill in "Phone Number" with "123-456-7890"
  When I fill in "Password" with "blah"
  And I press "submit"
  Then I should see "Invalid phone number or password"

Scenario: User attempts to sign in with an invalid phone number and correct password
  When I fill in "Phone Number" with "123456"
  When I fill in "Password" with "pass"
  And I press "submit"
  Then I should see "Invalid phone number or password"
  
Scenario: User attempts to sign in with an incorrect phone number and password
  When I fill in "Phone Number" with "12345"
  When I fill in "Password" with "blah"
  And I press "submit"
  Then I should see "Invalid phone number or password"
  
Scenario: User attempts to sign in with a correct phone number and correct password
  When I fill in "Phone Number" with "123-456-7890"
  When I fill in "Password" with "pass"
  And I press "submit"
  Then I should be on the user index
  And I should see "Welcome, Bob"
 
