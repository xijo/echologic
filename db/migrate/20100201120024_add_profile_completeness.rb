class AddProfileCompleteness < ActiveRecord::Migration
  def self.up
    add_column :profiles, :completeness, :float
  end

  def self.down
    remove_column :profiles, :completeness
  end
end
