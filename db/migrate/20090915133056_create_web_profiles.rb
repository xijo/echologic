class CreateWebProfiles < ActiveRecord::Migration
  def self.up
    create_table :web_profiles do |t|
      t.integer :user_id
      t.string :location
      t.integer :sort

      t.timestamps
    end
    add_index :web_profiles, [:user_id]
  end

  def self.down
    drop_table :web_profiles
  end
end
