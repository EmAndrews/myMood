Feature: Create categories as an admin

	As an admin
	So that more people can help manage myMood
	I want to create new admins
	
Background: I am an admin
	Given the following users exist:
  | phone_number   | name    | password  | email | is_admin |
  | 123-456-7890   | Admin   | hunter222 | a@a.a | true  |
  | 111-111-1111   | Bob B   | abcdefgh9 | b@b.b | false |

	Given I am on the myMood home page
	When I fill in "user_phone_number" with "123-456-7890"
	When I fill in "user_password" with "hunter222"
	And I press "Sign in"
	
Scenario: Create a new admin (successful)
	Given I am on the admin category page
	When I fill in "admin_phone_number_text" with "111-111-1111"
	And I press "Add Admin"
	
	Then I should see "Bob B has been given admin access"
	
	When I follow "Logout"
	Given I am on the myMood home page
	When I fill in "user_phone_number" with "111-111-1111"
	When I fill in "user_password" with "abcdefgh9"
	And I press "Sign in"
	
	Given I am on the admin category page
	Then I should see "Average Graphs for All Users"
	And I should see "Messages"
	And I should see "Categories"
	
Scenario: Create a new admin (unsuccessful - blank phone)
	Given I am on the admin category page
	When I fill in "admin_phone_number_text" with ""
	And I press "Add Admin"
	
	Then I should see "Sorry, there is no user that matches that phone number"
	
Scenario: Create a new admin (unsuccessful - bad number)
	Given I am on the admin category page
	When I fill in "admin_phone_number_text" with "123-111-1111"
	And I press "Add Admin"
	
	Then I should see "Sorry, there is no user that matches that phone number"
	
Scenario: Non-admin cannot see admin page
	When I follow "Logout"
	Given I am on the myMood home page
	When I fill in "user_phone_number" with "123-456-7890"
	When I fill in "user_password" with "hunter222"
	And I press "Sign in"
	
	Given I am on the admin category page
	Then I should not see "Average Graph for All Users"
	And I should not see "create_admin"
