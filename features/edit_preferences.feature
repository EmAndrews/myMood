Feature: change preferences

  As a user
  So that I can subscribe to messages and change when I want to get them
  I want to change my message and availability preferences

Background: users are in the database

  Given the following users exist:
  | phone_number | name | password  | email |
  | 222-222-2222 | Bob  | pass12345 | b@B.com |

  Given the following categories exist:
  | name | prefix |
  | mood | m      |
  | sleep | s     |

  And I am on the myMood home page
  When I fill in "user_phone_number" with "222-222-2222"
  When I fill in "user_password" with "pass12345"
  And I press "Sign in"
  And I am on the user index

Scenario: User subscribes to categories
  When I follow "Settings"
  Then I should see "Categories"
  And I should see "mood"
  And I should see "sleep"
  And the "category_id_mood" checkbox should be checked
  And the "category_id_sleep" checkbox should not be checked
  When I check "category_id_sleep"
  And I press "Subscribe"
  Then I should see "You have successfully subscribed to new categories!"
  When I follow "Setting"
  Then the "category_id_sleep" checkbox should be checked

Scenario: User changes 
  When I follow "Settings"
  Then I should see "Schedule"
  And I should see "M"
  And I should see "Tu"
  And I should see "W"
  And I should see "Th"
  And I should see "F"
  And I should see "Sa"
  And I should see "Su"
  And the "days_id_M" checkbox should be checked
  And the "days_id_Tu" checkbox should be checked
  And the "days_id_W" checkbox should be checked
  And the "days_id_Th" checkbox should be checked
  And the "days_id_F" checkbox should be checked
  And the "days_id_Sa" checkbox should be checked
  And the "days_id_Su" checkbox should be checked
  When I uncheck "days_id_M"
  And I press "Update"
  Then I should see "Your availability has been changed"
  When I follow "Settings"
  Then I should see "M"
  And the "days_id_M" checkbox should not be checked
