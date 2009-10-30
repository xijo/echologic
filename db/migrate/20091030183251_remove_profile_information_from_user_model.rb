class RemoveProfileInformationFromUserModel < ActiveRecord::Migration
  def self.up
    remove_column :users, :gender
    remove_column :users, :about_me
    remove_column :users, :motivation
    remove_column :users, :city
    remove_column :users, :country
    remove_column :users, :first_name
    remove_column :users, :last_name 
  end

  def self.down
    add_column :users, :gender,     :integer
    add_column :users, :about_me,   :text
    add_column :users, :motivation, :text
    add_column :users, :city,       :string
    add_column :users, :country,    :string
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
  end
end
