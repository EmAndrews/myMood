class AddSeqNumToMessageTemplate < ActiveRecord::Migration
  def change
    add_column :message_templates, :sequence_number, :integer
    add_column :users, :is_admin, :boolean, default: false
  end
end
