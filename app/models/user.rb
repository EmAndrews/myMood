class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone_number, :name
  # attr_accessible :title, :body

  before_save do
  	phone_number = convert_phone (phone_number)
  end

  # Trying to mimic devise. 
  validates :phone_number,
  	:uniqueness => true,
  	:presence => true,
		:phone_number => {:format => /^\(*\d{3}\)*-*\s*\d{3}-*\s*\d{4}/}

  validates_presence_of :name

  def convert_phone (number)
  
		phone_regex = /^\(*(?<start>\d{3})\)*-*\s*(?<middle>\d{3})-*\s*(?<end>\d{4})/
		data = phone_regex.match(number)
		
		p number
		
		unless data
			return number
		end
		
		newNumber = "+1" + data[:start] + data[:middle] + data[:end]
		
		return newNumber
	end

end
