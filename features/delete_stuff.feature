Feature: Delete stuff as admin

	As an admin
	So that I can remove outdated messages and categories
	I want to delete messages and categories

Background: I am an admin
	Given the following users exist:
    | phone_number | name | password   | email | is_admin |
    | 111-111-1111 | Admin | admin_password | a@a.a | true|
    
  Given the following categories exist:
  | name | prefix |
  | mood | m      |
  | sleep | s     |

  Given I am on the myMood home page
	When I fill in "user_phone_number" with "111-111-1111"
	When I fill in "user_password" with "admin_password"
	And I press "Sign in"
	
	Given I am on the admin category page
	When I fill in "message_text" with "How are you feeling today?"
	When I select "mood" from "message_category"
	And I press "Add Message"
	
	Given I am on the admin category page
	When I fill in "message_text" with "words words words"
	When I select "mood" from "message_category"
	And I press "Add Message"
	
Scenario: Delete Category
	When I press "category-m"
	Then I should see "Category 'mood' and messages deleted."
	
Scenario: Delete Message
	When I press "message-0"
	Then I should see "Message 'How are you feeling today?' deleted."
