class UserState < ActiveRecord::Base

  belongs_to User

 @categories

 #Create entry in hash for a category
 def add_category(category)
  
 end

 #Change entry in hash for a category to have new seq_num
 def modify_state(category, seq_num)

 end

 def remove_category(category)

 end

end
