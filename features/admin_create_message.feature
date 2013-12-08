Feature: Create messages as an admin

	As an admin
	So that users can recieve the messages they care about
	I want to create messages in categories
	
Background: I am an admin
	Given the following users exist:
    | phone_number | name | password   | email | is_admin |
    | 111-111-1111 | Admin | admin_password | a@a.a | true|

  Given I am on the myMood home page
	When I fill in "user_phone_number" with "111-111-1111"
	When I fill in "user_password" with "admin_password"
	And I press "Sign in"
	
	Given I am on the admin category page
	
	When I fill in "category_name" with "Mood"
	And I fill in "category_prefix" with "m"
	And I press "Add Category"

Scenario: Create a message (correct)
	When I fill in "message_text" with "How are you feeling today?"
	When I select "Mood" from "message_category"
	And I press "Add Message"
	
	Then I should see "Message 'How are you feeling today?' added in category 'Mood'"
	
Scenario: Create a message (blank)
	When I select "Mood" from "message_category"
	And I press "Add Message"
	
	Then I should see "Message cannot be blank."
