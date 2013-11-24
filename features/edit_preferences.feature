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

  And I am on the myMood homepage
  When I fill in "user_phone_number" with "222-222-2222"
  When I fill in "user_password" with "pass12345"
  And I press "Sign in"
  And I am on the user index

Scenario: User subscribes to categories
  When I follow "Settings"
  Then I should see "Categories"
  And I should see "mood"
  And I should see "sleep"
  And the mood checkbox should not be checked
  And the sleep checkbox should not be checked
  When I check sleep
  And I press "Subscribe"
  Then I should see "You have successfully subscribed to categories"
  When I follow "Home"
  When I follow "Setting"
  Then the sleep checkbox should be checked
  # should check the cheking and unchecking of boxes at some point

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
  And the "M" checkbox should be checked
  And the "Tu" checkbox should be checked
  And the "W" checkbox should be checked
  And the "Th" checkbox should be checked
  And the "F" checkbox should be checked
  And the "Sa" checkbox should be checked
  And the "Su" checkbox should be checked
  When I uncheck "M"
  And I press "Update"
  Then I should see "You have successfully updates your availability"
  Then the "M" checkbox should be unchecked
