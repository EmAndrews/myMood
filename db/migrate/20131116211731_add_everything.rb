class AddEverything < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      # has_one :sequence
      # has_one :schedule
      t.timestamps
    end


    create_table :messages do |t|
      t.belongs_to :conversation
      t.belongs_to :sequence
      t.text :text
      t.timestamps
    end


    create_table :sequences do |t|
      # has_many messages
      t.belongs_to :category
      t.timestamps
    end


    create_table :user_messages do |t|
      # has_many messages
      t.belongs_to :user
      t.string :type
      t.timestamps
    end

    create_table :schedules do |t|
      t.belongs_to :category
      t.string :unit
      t.integer :number_of
    end

    create_table :schedule_preferences do |t|
      t.belongs_to :user
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
    end

    create_table :user_states do |t|
      t.belongs_to :user
      t.belongs_to :category
      t.integer :seq_num
    end
  end

  def down
  end
end
