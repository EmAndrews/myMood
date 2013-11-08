Feature: view user graphs as admin

        As an admin
        So that I can view trends and discuss moods with a group of users
        I want to view a group's mood graphs

Background: Users 1, 2, and 3 have submitted moods every day for the past two weeks

Given the following moods exist:

  | created_at  | mood_score | user_id  |
  | 12-Oct-2013 | 3 		| 1	|
  | 13-Oct-2013 | 4 		| 1	|
  | 14-Oct-2013 | 3 		| 1	|
  | 15-Oct-2013 | 5 		| 1	|
  | 16-Oct-2013 | 7 		| 1	|
  | 17-Oct-2013 | 2 		| 1	|
  | 18-Oct-2013 | 5 		| 1	|
  | 19-Oct-2013 | 3 		| 1	|
  | 20-Oct-2013 | 4 		| 1	|
  | 21-Oct-2013 | 3 		| 1	|
  | 22-Oct-2013 | 5 		| 1	|
  | 23-Oct-2013 | 7 		| 1	|
  | 24-Oct-2013 | 2 		| 1	|
  | 25-Oct-2013 | 5 		| 1	|
  | 12-Oct-2013 | 7 		| 2	|
  | 13-Oct-2013 | 4 		| 2	|
  | 14-Oct-2013 | 5 		| 2	|
  | 15-Oct-2013 | 6 		| 2	|
  | 16-Oct-2013 | 2 		| 2	|
  | 17-Oct-2013 | 1 		| 2	|
  | 18-Oct-2013 | 8 		| 2	|
  | 19-Oct-2013 | 3 		| 2	|
  | 20-Oct-2013 | 2 		| 2	|
  | 21-Oct-2013 | 1 		| 2	|
  | 22-Oct-2013 | 7 		| 2	|
  | 23-Oct-2013 | 5 		| 2	|
  | 24-Oct-2013 | 6 		| 2	|
  | 25-Oct-2013 | 9 		| 2	|
  | 12-Oct-2013 | 2 		| 3	|
  | 13-Oct-2013 | 8 		| 3	|
  | 14-Oct-2013 | 9 		| 3	|
  | 15-Oct-2013 | 7 		| 3	|
  | 16-Oct-2013 | 8 		| 3	|
  | 17-Oct-2013 | 9 		| 3	|
  | 18-Oct-2013 | 6 		| 3	|
  | 19-Oct-2013 | 2 		| 3	|
  | 20-Oct-2013 | 1 		| 3	|
  | 21-Oct-2013 | 4 		| 3	|
  | 22-Oct-2013 | 6 		| 3	|
  | 23-Oct-2013 | 4 		| 3	|
  | 24-Oct-2013 | 3 		| 3	|
  | 25-Oct-2013 | 8 		| 3	|
  
  
Scenario: View entire mood graph
  
  When I am on the home page
  And I follow "Mood Graphs"
  
  Then I should see a graph
