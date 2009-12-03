class UpdateStatementPublishedToState < ActiveRecord::Migration
  def self.up
    remove_column :statements, :published
    add_column :statements, :state, :integer
  end

  def self.down
    remove_column :statements, :state
    add_column :statements, :published, :boolean
  end
end
