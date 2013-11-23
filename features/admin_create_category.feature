Feature: Create categories as an admin

	As an admin
	So that users can subscribe to categories they want
	I want to create categories for messages
	
Background: I am an admin
	Given I am on the myMood home page
	When I fill in "user_phone_number" with "111-111-1111"
	When I fill in "user_password" with "admin_password"
	And I press "Sign in"
	
	Given I am on the admin category page
	
Scenario: Create a category (correct parameters)
  When I fill in "category_name" with "Mood"
	And I fill in "category_prefix" with "m"
	And I press "Add Category"
	
	Then I should see "Category 'Mood' created!"
	
Scenario: Create a category (no prefix)
  When I fill in "category_name" with "Mood"
	And I press "Add Category"
	
	Then I should see "Please include a category name and prefix."
	
Scenario: Create a category (no name)
	And I fill in "category_prefix" with "m"
	And I press "Add Category"
	
	Then I should see "Please include a category name and prefix."
	
Scenario: Create a category (bad prefix - parser problem)
  When I fill in "category_name" with "Mood"
	And I fill in "category_prefix" with "m10"
	And I press "Add Category"
	
	Then I should see "Only letters are allowed in the prefix."
	
Scenario: Create a category (bad prefix - parser problem)
  When I fill in "category_name" with "Mood"
	And I fill in "category_prefix" with "my mood"
	And I press "Add Category"
	
	Then I should see "Only letters are allowed in the prefix."
