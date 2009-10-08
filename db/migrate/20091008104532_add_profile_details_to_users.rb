class AddProfileDetailsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :about_me, :text
    add_column :users, :motivation, :text
    add_column :users, :city, :string
    add_column :users, :country, :string
  end

  def self.down
    remove_column :users, :about_me
    remove_column :users, :motivation
    remove_column :users, :city
    remove_column :users, :country
  end
end
