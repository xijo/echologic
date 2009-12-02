class RemoveStatementsActivated < ActiveRecord::Migration
  def self.up
    remove_column :statements, :activated
  end

  def self.down
    add_column :statements, :activated, :boolean
  end
end
