class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone_number, :name
  # attr_accessible :title, :body

  before_validation(on: :create) do
  	self.phone_number = "+1" + phone_number.gsub(/[^0-9]/, "") if attribute_present?("phone_number") 
  end

  # Trying to mimic devise. 
  validates :phone_number,
  	:uniqueness => true,
  	:presence => true,
		:phone_number => {:format => /^\+1\d{10}/}

  validates_presence_of :name

end
