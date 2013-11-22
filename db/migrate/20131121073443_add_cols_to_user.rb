class AddColsToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscription, :string
    add_column :users, :availability, :string
  end
end
