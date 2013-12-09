#Fill in default messages.  Use this for subscription testing
Given /^the following categories exist with messages:$/ do |table|
  table.hashes.each do |cat|
    c = Category.create!(cat)
    MessageTemplate.create!(:category => c, :sequence_number => 0)
  end
end

#No default messages.  Useful for admin interface testing
Given /^the following categories exist:$/ do |table|
  table.hashes.each do |cat|
    Category.create!(cat)
  end
end

Then /^I should see a graph$/ do
#puts page.html
    page.html.include?("1B").should == true
end
