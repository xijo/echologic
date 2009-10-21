class AddGenderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :integer
  end

  def self.down
    remove_column :users, :gender
  end
end
