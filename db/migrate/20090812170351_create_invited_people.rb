class CreateInvitedPeople < ActiveRecord::Migration
  def self.up
    create_table :invited_people do |t|
      t.string :name
      t.string :email
      t.integer :interested_person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :invited_people
  end
end
