Feature: Download CSV File

	As an admin
	So that I can analyze mood trends for research purposes
	I want to download a csv of message data

Background: I am an admin
	Given the following users exist:
    | phone_number | name | password   | email | is_admin |
    | 111-111-1111 | Admin | admin_password | a@a.a | true|
    
  Given I am on the myMood home page
	When I fill in "user_phone_number" with "111-111-1111"
	When I fill in "user_password" with "admin_password"
	And I press "Sign in"
	
Scenario: I should see a download button
	Given I am on the admin category page
	Then I should see "Download CSV"
	
Scenario: Should be on admin page after download
	Given I am on the admin category page
	When I press "download_csv"
	Then I should be on the admin category page
