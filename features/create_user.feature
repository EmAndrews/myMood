Feature: create new user
 
  As a user
  So that I can use myMood
  I want to create a myMood account
  
Background: users are in the database
  
  Given the following users exist:
  | phone_number | name    | password  | email |
  | 123-456-7890   | Alice   | hunter222 | a@a.a |
  | 111-111-1111   | Bob B   | abcdefgh9 | b@b.b |

  And I am on the sign up page
  
Scenario: Correct Information with an email
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then "Carol" should be created with "222-222-2222", "password123", "carol@foo.com"
	And I should be on the user index
  And I should see "Welcome! You have signed up successfully"


Scenario: Missing Email
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	
	And I press "Sign up"

	Then I should see "Email can't be blank"
	
Scenario: Invalid Email
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@f"
	
	And I press "Sign up"

	Then I should see "Email is invalid"
	

Scenario: Missing User Name
	When I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Name can't be blank"
	

Scenario: Missing Phone Number
  When I fill in "user_name" with "Carol"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Phone number can't be blank"
	

Scenario: Missing Password
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Password can't be blank"
	
Scenario: Missing Confirm Password
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Password doesn't match confirmation"
	
Scenario: Password and Cofirm Password don't match
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "222-222-2222"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "Password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Password doesn't match confirmation"
	
Scenario: Phone Number taken
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "123-456-7890"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Phone number has already been taken"
	
Scenario: Invalid Phone Number
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "123"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Phone number 123 is not valid"
	
Scenario: Invalid Phone Number (non-number)
	When I fill in "user_name" with "Carol"
	And I fill in "user_phone_number" with "not a number"
	And I fill in "user_password" with "password123"
	And I fill in "user_password_confirmation" with "password123"
	And I fill in "user_email" with "carol@foo.com"
	
	And I press "Sign up"

	Then I should see "Phone number not a number is not valid"
