Given /the following users exist/ do |user_table|   #populates a table?  this is based on hw3
  user_table.hashes.each do |user|
    User.create!(user)
  end
end

#Then "Carol" should be created with "2222222222", "password123", ""
Then /"(.*)" should be created with "(.*)", "(.*)", "(.*)"/ do |user, phone, pass, email|
  user = User.find(phone)
  
  user.phone.should be phone
  user.name.should be name
  user.pass.should be pass
  user.email.should be email
end
