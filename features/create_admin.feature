Feature: Create categories as an admin

	As an admin
	So that more people can help manage myMood
	I want to create new admins
	
Background: I am an admin
	Given the following users exist:
  | phone_number   | name    | password  | email | is_admin |
  | 123-456-7890   | Admin   | hunter222 | a@a.a | True  |
  | 111-111-1111   | Bob B   | abcdefgh9 | b@b.b | False |

	Given I am on the myMood home page
	When I fill in "user_phone_number" with "123-456-7890"
	When I fill in "user_password" with "hunter222"
	And I press "Sign in"
	
Scenario: Admin creation interface
	Given I am on the admin category page
	Then I should see "To create a new admin, first create a normal account."
	And I should see "Then, input that user's phone number and name."
	And I should see "The name you give must match the name on the account."
	
Scenario: Create a new admin (successful)
	Given I am on the admin category page
	When I fill in "admin_number" with "111-111-1111"
	And I fill in "admin_name" with "Bob B"
	And I press "create_admin"
	
	Then I should see "'111-111-1111' is now an admin."
	
	When I follow "Logout"
	Given I am on the myMood home page
	When I fill in "user_phone_number" with "123-456-7890"
	When I fill in "user_password" with "hunter222"
	And I press "Sign in"
	
	Given I am on the admin category page
	Then I should see "Average Graph for All Users"
	And I should see "Messages"
	And I should see "Categories"
	
Scenario: Create a new admin (unsuccessful - blank phone)
	Given I am on the admin category page
	When I fill in "admin_number" with ""
	And I fill in "admin_name" with "Bob B"
	And I press "create_admin"
	
	Then I should see "Phone number cannot be blank."
	
Scenario: Create a new admin (unsuccessful - bad number)
	Given I am on the admin category page
	When I fill in "admin_number" with "123-111-1111"
	And I fill in "admin_name" with "Bob B"
	And I press "create_admin"
	
	Then I should see "Could not find user '123-111-1111'"
	
Scenario: Create a new admin (unsuccessful - bad name)
	Given I am on the admin category page
	When I fill in "admin_number" with "111-111-1111"
	And I fill in "admin_name" with "B Bob"
	And I press "create_admin"
	
	Then I should see "'B Bob' does not match the name on file for '111-111-1111'"
	
	When I follow "Logout"
	Given I am on the myMood home page
	When I fill in "user_phone_number" with "123-456-7890"
	When I fill in "user_password" with "hunter222"
	And I press "Sign in"
	
	Given I am on the admin category page
	Then I should not see "Average Graph for All Users"
	
Scenario: Non-admin cannot see admin page
	When I follow "Logout"
	Given I am on the myMood home page
	When I fill in "user_phone_number" with "123-456-7890"
	When I fill in "user_password" with "hunter222"
	And I press "Sign in"
	
	Given I am on the admin category page
	Then I should not see "Average Graph for All Users"
	And I should not see "create_admin"
