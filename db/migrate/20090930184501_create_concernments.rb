class CreateConcernments < ActiveRecord::Migration
  def self.up
    create_table :concernments do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :sort

      t.timestamps
    end
    add_index :concernments, [:user_id, :sort]
    add_index :concernments, [:sort]
  end

  def self.down
    drop_table :concernments
  end
end
