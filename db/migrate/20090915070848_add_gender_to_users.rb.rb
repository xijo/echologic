class AddGenderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :boolean
  end

  def self.down
    remove_column :users, :gender
  end
end
