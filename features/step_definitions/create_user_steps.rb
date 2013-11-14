Given /the following users exist/ do |user_table|   #populates a table?  this is based on hw3
  user_table.hashes.each do |user|
    User.create!(user)
  end
end

# Then "Carol" should be created with "2222222222", "password123", ""
# Taking out password check because password is encrypted and we can't see value.
Then /"(.*)" should be created with "(.*)", "(.*)", "(.*)"/ do |name, phone, pass, email|
  user = User.find_by_phone_number(phone)
  user.name.should eq(name)
  user.email.should eq(email)
end
