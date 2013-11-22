class AddNewBackend < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      t.string :prefix
      t.belongs_to :processed_message
      t.timestamps
      # has_many message_templates
      # has_one :message_sequence
    end

    create_table :message_templates do |t|
      t.belongs_to :category
      t.string :text
      t.timestamps
    end

    create_table :message_sequences do |t|
      t.belongs_to :category
      t.string :sequence #serialized hash
      t.timestamps
    end

    create_table :processed_messages do |t|
      # has_one :category
      t.belongs_to :user
      t.string :text
      t.string :data
      t.integer :from_my_mood
      t.datetime :date_processed
      t.timestamps
    end
  end

  def down
  end
end
