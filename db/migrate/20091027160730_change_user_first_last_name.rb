class ChangeUserFirstLastName < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :last_name
    rename_column :users, :prename, :first_name
  end

  def self.down
    rename_column :users, :last_name, :name
    rename_column :users, :first_name, :prename
  end
end
