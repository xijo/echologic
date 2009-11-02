class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :reporter_id
      t.integer :suspect_id
      t.text :reason
      t.boolean :done, :default => false
      t.text :decision

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
