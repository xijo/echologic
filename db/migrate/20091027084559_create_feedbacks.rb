class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :message
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
