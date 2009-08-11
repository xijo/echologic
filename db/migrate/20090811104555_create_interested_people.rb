class CreateInterestedPeople < ActiveRecord::Migration
  def self.up
    create_table :interested_people do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :interested_people
  end
end
