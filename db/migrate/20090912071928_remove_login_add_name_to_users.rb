class RemoveLoginAddNameToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :login
    add_column :users, :name, :string
    add_column :users, :prename, :string
  end

  def self.down
    add_column :users, :login, :string
    remove_column :users, :name
    remove_column :users, :prename
  end
end
