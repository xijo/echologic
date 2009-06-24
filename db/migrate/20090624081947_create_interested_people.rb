class CreateInterestedPeople < ActiveRecord::Migration
  def self.up
    create_table :interested_people do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :interested_people
  end
end
