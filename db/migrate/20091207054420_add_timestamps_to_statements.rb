class AddTimestampsToStatements < ActiveRecord::Migration
  def self.up
    add_timestamps(:statements)
  end

  def self.down
    remove_timestamps(:statements)
  end
end
