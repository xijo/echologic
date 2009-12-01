class CreateStatements < ActiveRecord::Migration
  def self.up
    create_table :statements do |t|
      t.string :title
      t.text :text
      t.string :type
      t.integer :user_id
      t.integer :parent_id
      t.integer :root_id
    end
  end

  def self.down
    drop_table :statements
  end
end
