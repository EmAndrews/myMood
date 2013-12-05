class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  

  has_many :processed_messages

  # Setup accessible (or protected) attributes for your model
# # :Subsription is json object.
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone_number, :name, :subscription, :availability, :is_admin
  # attr_accessible :title, :body

  # Trying to mimic devise. 
  validates :phone_number,
  	:uniqueness => true,
  	:presence => true,
		:phone_number => {:format => /\d{3}-\d{3}-\d{4}/}

  validates_presence_of :name
  
  before_create :initial_sign_up
  
  serialize :subscription, Hash
  serialize :availability, Hash

  def wants_messages_today
    day = Time.now.wday
    pre = Util.week_day_prefix_map[day]
    puts "User> pre: #{pre}, avail: #{self.availability.keys}"
    return self.availability.keys.include? pre
  end

  def subscribed_categories
    return self.subscription.keys
  end


  def add_sent_message_to_conversation mess
    ProcessedMessages.create!(:text => mess.text, :data => nil,
                    :from_my_mood => true, :date_processed => Time.now)
  end

  private
    def initial_sign_up
      self.availability = {"M" => [], "Tu" => [], "W" => [], "Th" => [],
                            "F" => [], "Sa" => [], "Su" => [] }
      self.subscription = {"1" => {}}
    end
end
