class SetupEchos < ActiveRecord::Migration
  def self.up
    create_table :echos do |t|
      t.integer :visitor_count, :default => 0
      t.integer :supporter_count, :default => 0
    end
    create_table :echo_details do |t|
      t.integer :echo_id
      t.integer :user_id
      t.boolean :visited
      t.boolean :supported
    end
    add_index :echo_details, :echo_id
    add_index :echo_details, :user_id # do we need this?
    add_column :statements, :echo_id, :integer
  end

  def self.down
    drop_table :echos
    drop_table :echo_details
    remove_column :statements, :echo_id
  end
end
