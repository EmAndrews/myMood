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
  after_create :welcome_message
  serialize :subscription, Hash
  serialize :availability, Hash

  def wants_messages_today
    day = Time.now.wday
    pre = Util.week_day_prefix_map[day]
    puts Util.week_day_prefix_map
    puts pre
    puts self.availability.keys
    return self.availability.keys.include? pre
  end

  def subscribed_categories
    return self.subscription.keys
  end


  def add_sent_message_to_conversation mess
    ProcessedMessages.create!(:text => mess.text, :data => nil,
                    :from_my_mood => true, :date_processed => Time.now)
    self.save!
  end

  private
    def initial_sign_up
      self.availability = {}
      Util.week_day_prefixes.map {|p| self.availability[p] = []}
      #TODO Fill me in with the default subscription.
      if Category.all.blank?
      	return
      end
      if Category.all[0].message_templates.blank?
      	return
      end
      self.subscription = {Category.all[0].id.to_s =>
                            {:next_message => Category.all[0].message_templates[0].id}
                          }
    end

    def welcome_message
    end
end
