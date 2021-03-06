Welcome to myMood!

README sections:

1. ADMIN INTERFACE: Once everything is set up, instructions for performing basic (GUI) tasks.
2. CONSOLE/CODE: Slightly more technical, covers initial set up, how to change numbers, etc.
3. SUPER TECHY CODE STUFF: Meant for those who are trying to maintain/change this code.


ADMIN INTERFACE

	*** To create a new admin as an admin: ***
1. Create a new account normally.
2. Log in as an existing admin
3. Go to the admin page
4. Fill in "New Admin Phone Number" with the admin's number (###-###-####)
5. Click "Add Admin"

	*** To add new categories: ***
1. Log in as an admin
2. Go to the admin page
3. Click "Add new Category"
4. Fill in Category Name and Category Prefix
5. Click the create button
Note: Make sure each category contains at least one message!

	*** To add messages: ***
1. Log in as an admin
2. Go to the admin page
3. Click "Add Message"
4. Select a category from the dropdown menu
5. Type in your message.
6. Click the create button

	*** To delete messages/categories: ***
1. Log in as an admin
2. Go to the admin page
3. Click the "x" button next to whatever you'd like to delete
4. Confirm the deletion.







CONSOLE/CODE (For techy people)

	*** To create the first admin: ***
1. Create a new account for the admin normally, through the web interface.
2. In the terminal, run: rails console
For Heroku, in the terminal run: heroku rails console
3. In the console:
	> new_admin = User.find_by_phone_number('###-###-####')
	> new_admin.is_admin = true
	> new_admin.save!

	*** To change the Twilio Number: ***
1. Go to lib/util.rb
	In the method "self.send_message(to, message)"
	Change sid, token, and twilio_number (+1##########) to the new values
2. On Twilio, log in and go to "Configure your number".
	Change the "Messaging Request URL" to "your-new-url.com/sms/receive_sms"
	Click "Save"

	*** To start up Scheduling: ***
Note: We haven't been able to test this on heroku due to multiple processes/dynos.
To run scheduling locally, open 3 terminals.
Run the following commands, one in each terminal:
	> bundle exec rails server
	> bundle exec clockwork app/clock.rb
	> bundle exec rake jobs:work

	*** To change the text on the myMood homepage: ***
Go to app/views/devise/sessions/new.html.haml
Change the old text to whatever you'd like it to say on the homepage

	*** To remove an admin: ***
1. 
2. In the terminal, run: rails console
For Heroku, in the terminal run: heroku rails console
3. In the console:
	> admin = User.find_by_phone_number('###-###-####')
	> admin.is_admin = false
	> admin.save!









SUPER TECHY CODE STUFF - Please ignore if you're not a super techy code person

	*** Tests ***
We have tests!  Yay!  (About 90% code coverage as we write this, main functionality is well tested except for graphs.)
rspec: Unit tests (rake spec)
cucumber: Integration tests (rake cucumber)
Note: Twilio number might need to be updated in spec files.


	*** Gems ***
Login/Auth: Devise (must be configured/tortured to accept phone number as login)
Texting: Twilio (See sms_controller/receive_text, or lib/Util.send_text)
Texting Tests: sms-spec (ignore this if you're not doing TDD)
Scheduling: Clockwork + Delayed Job
Pretty graphs: HighCharts (javascript library)


	*** Database-y (non-obvious) Stuff/Notes ***
*** Models:
MessageTemplate: The things that will be (or have been sent as) messages from myMood to a user.
	These belong to categories.
ProcessedMessages: Things that have actually been sent from myMood, or were sent TO myMood from a user.
	There is always a user_id, either who sent to myMood or who myMood sent to.
	Parse-able messages from the user will store the mood rating as its data.
lib/util.rb: send_message and other utilities live here
User: Also admins, when is_admin is true.
model.rb: Auto-generated by Devise, do not delete, do not use.  Just...  leave it.

*** Controllers:
admin_controller: Does a lot of stuff on the admin page
	+ Create categories, messages, admins
	+ Delete categories, messages
	+ Download csv file
andre_controller: Old testing environment, git likes to add it, should be removed.
sms_controller: Handles receiving/saving/replying to text messages, sending is handled in lib/util


	*** Changing myMood to multiple Twilio numbers: ***
Vic and Adrian suggested that they would like different phone numbers for different
categories.  The suggestion came too late for us to implement it.  It requires some extra work.

1. Store the new numbers (and sid/tokens) in some sort of table, or hardcode them in
	Make sure this is accessible to lib/Util.rb
	
2. In lib/util.rb, change send_sms to handle different twilio_numbers
	You'll need some conditionals to get the proper sid/token for the number
	You'll also need a new parameter (which number to text from)
	We suggest overloading the method (does that work in ruby?) so a default number can send out things like "welcome to myMood" and error messages

3. In sms_controller.rb, receive_sms has: regex = /^\s*(?<letter>[a-zA-Z]+)\s*(?<rating>\d+)\s*(?<message>.*)/
	'(?<letter>[a-zA-Z]+)' looks for a prefix, remove that.
	Change the logic in handle_readable_sms_from_valid_user to use the 'to' variable (twilio number) to determine a category
	Change the Util.send_sms statements to account for changing twilio numbers
	
4. Add fields on the admin page so new numbers can easily be created and added

